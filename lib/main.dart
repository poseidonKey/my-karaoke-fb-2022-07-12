import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/screens/home_page.dart';
import 'package:my_karaoke_firebase/screens/message_list_screen.dart';
import 'package:my_karaoke_firebase/screens/signin_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase cli',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: HomePage(),
      home: Builder(
          // builder: (context) =>
          builder: (context) {
        // print(isAuthenticated(context));
        // return HomePage();
        return SigninPage();
        // return MessageListScreen();
      }),
    );
  }

  
}
