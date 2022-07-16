import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/screens/signin_page.dart';
import 'firebase_options.dart';
import 'models/song_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase Songs Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ElevatedButton(
          onPressed: () async {
            getAllSongs("ALXyp4TcnKeefbKcgq9emzH43z12");
          },
          child: Text("load")),
      // home: HomePage(),
      // home: Builder(
      //     // builder: (context) =>
      //     builder: (context) {
      //   // print(isAuthenticated(context));
      //   // return HomePage();
      //   // return const SigninPage();
      //   // return MessageListScreen();
      // }),
    );
  }

  Future<void> getAllSongs(String userId) async {
    try {
      QuerySnapshot userSongsSnapshot = await FirebaseFirestore.instance
          .collection('songs')
          .doc(userId)
          .collection("userSongs")
          // .orderBy("timestamp", descending: true)
          .get();
      List<Song?> songs = userSongsSnapshot.docs.map(
        (songDoc) {
          Song.fromMap(
              id: songDoc.id, map: songDoc.data() as Map<String, dynamic>);
        },
      ).toList();
      print(songs);
      // allSongs = RxList(songs);
    } catch (e) {
      print(e);
    }
  }
}
