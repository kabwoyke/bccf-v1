import 'package:bccf/screens/homepage.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/services/cache/AnnouncementNotification.dart';
import 'package:bccf/services/cache/NotificationDatabase.dart';
import 'package:bccf/services/notification_service.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  final NotificationDatabase _notificationDatabase = NotificationDatabase();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationDatabase.init().then((_) {
    NotificationDatabase().startListeningToNotifications();
  });
  NotificationService().initNotification();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  );

  void sendNotification(RemoteMessage event) async{
    // _notificationDatabase.notificationsStream;
    final notification = event.notification;
    if( notification!= null){
      NotificationService()
          .showNotification(
          title: notification.title,
          body: notification.body);
      print("Kiasi");
      if (event.data.isNotEmpty) {
          _notificationDatabase.addNotification(AnnouncementNotification(title: notification.title, content: notification.body, id: int.parse(event.data['id'])));
          _notificationDatabase.fetchNotification();
      }
    }
  }
  FirebaseMessaging.onMessage.listen(sendNotification);
  FirebaseMessaging.onBackgroundMessage(onMessageBackground);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> onMessageBackground(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Assuming NotificationDatabase.init() properly initializes the Isar database
  // and that startListeningToNotifications() sets up a stream listener internally.
  await NotificationDatabase.init();
  final notObj = NotificationDatabase();
  notObj.startListeningToNotifications(); // Start listening to changes.

  print("Handling a background message: ${message.notification?.title}");
  final notification = message.notification;
  if(notification != null){
    // Trigger local notification display
    NotificationService().showNotification(
        title: notification.title,
        body: notification.body);

    await notObj.addNotification(
        AnnouncementNotification(
            title: notification.title,
            content: notification.body,
            id: int.parse(message.data['id']))
    );

    await NotificationDatabase.close();

    // No need to manually close the Isar database here as it might interrupt other operations.
  }
}


final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_)=>AuthProvider()),
          ChangeNotifierProvider<NotificationDatabase>(create: (_)=> NotificationDatabase()),
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
  final NotificationDatabase _notificationDatabase = NotificationDatabase();
  static late Isar isar;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        // _notificationDatabase.addNotification(AnnouncementNotification(title: "boom", content: "boom", id: 3));
        _notificationDatabase.fetchNotification();

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



    // @pragma('vm:entry-point')
    // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    //   await Firebase.initializeApp();
    //   // _notificationDatabase.addNotification(AnnouncementNotification(title: "leta", content: "leta", id: 4));
    //   print("Handling a background message: ${message}");
    // }
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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


  // void addToCache(int id , String title , String content){
  //   context.read<NotificationDatabase>().addNotification(id, title, content);
  // }
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

