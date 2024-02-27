import 'package:bccf/screens/homepage.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/services/cache/NotificationDatabase.dart';
import 'package:bccf/services/notification_service.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:bccf/state/NotificationProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationDatabase.init();
  NotificationService().initNotification();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );

  runApp(const MyApp());
}


final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_)=>AuthProvider()),
          ChangeNotifierProvider<NotificationProvider>(create: (_)=>NotificationProvider())
        ],

        child: MaterialApp(
        title: 'BCCF',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: "Home Page",),

    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<NotificationProvider>(context,listen: false).fetchNotificationCount();
    });
    supabase.auth.onAuthStateChange.listen((event) async {
 
      if (event.event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission(alert: true , sound: true);
        await FirebaseMessaging.instance.subscribeToTopic("all");
        await FirebaseMessaging.instance.getAPNSToken();
        var fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
          await addToken(fcmToken);
        }


      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
        await addToken(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if( notification!= null){
        NotificationService()
            .showNotification(
            title: notification.title,
            body: notification.body);
      }
      print(event.notification?.title);
    });
  }

  Future<void> addToken(String token) async {
    var userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      print(userId);
      await supabase
          .from("fcm_tokens")
          .upsert({'user_id': userId, 'token': token});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
             StreamBuilder<AuthState>(
                stream: supabase.auth.onAuthStateChange,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error.toString()}"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data?.session == null) {
                    return LoginScreen();
                  }

                  return Homepage();


                })
        );


  }
}

