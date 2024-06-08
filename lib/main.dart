import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './details.dart';
import './push_notifications.dart';

//function to listen to bg changes
Future _firebaseBAckgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotification.init();
  //Listen to bg notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBAckgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LiteHarvest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('LiteHarvest'),
              backgroundColor: Colors.black,
              centerTitle: true,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Details(),
            )));
  }
}
