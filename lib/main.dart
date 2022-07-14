import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_karaoke_firebase/screens/signin_page.dart';
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
        return const SigninPage();
        // return MessageListScreen();
      }),
    );
  }
}
