import 'package:bccf/screens/homepage.dart';
import 'package:bccf/screens/login.dart';
import 'package:bccf/state/AuthProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.onGrantedCallback(() {
    print("hello perm");
  }).request();
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
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: Homepage(),
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
    supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
      if (event.event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getAPNSToken();
        var fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
        if (fcmToken != null) {
          await addToken(fcmToken);
        }
        FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
          if (fcmToken != null) {
            await addToken(fcmToken);
          if (fcmToken != null) {
            await addToken(fcmToken);
          }
        });
      }
    });
  }

  Future<void> addToken(String token) async {
    var userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      print(userId);
      await supabase
          .from("fcm_tokens")
          .upsert({'user_id': userId, 'token': token});
      await supabase
          .from("fcm_tokens")
          .upsert({'user_id': userId, 'token': token});
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: const LoginScreen());
  }
}
