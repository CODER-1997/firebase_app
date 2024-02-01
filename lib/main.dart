import 'dart:io';

import 'package:firebase_app/screens/auth/sign_in.dart';
import 'package:firebase_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyAv5JA2SftYQUCJQhT5NAZq3713oEiCnAs",
              appId: "1:709882797464:android:290ac449f8318fea3ddfed",
              messagingSenderId: "709882797464",
              projectId: "fir-app-5ba93"))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,  AsyncSnapshot<User?> snapshot) {
          final user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting....');
            return Center(child: CircularProgressIndicator(color: Colors.red));

          } else if (user != null) {
            print("user is logged in");
            print(user);
            return Home();
          } else {
            print("user is not logged in");
            return SignIn();
          }
        },
      ),);
  }
}
