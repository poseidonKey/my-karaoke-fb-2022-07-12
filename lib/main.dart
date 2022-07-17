// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/screens/signin_page.dart';
import 'firebase_options.dart';
// import 'models/my_song_data_fb_model.dart';
// import 'models/song_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Songs Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: ElevatedButton(
      //     onPressed: () async {
      //       // getAllSongs("ALXyp4TcnKeefbKcgq9emzH43z12");
      //       // getDetailsList("ALXyp4TcnKeefbKcgq9emzH43z12");
      //     },
      //     child: const Text("load")),
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
