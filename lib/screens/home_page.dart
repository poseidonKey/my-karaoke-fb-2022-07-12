import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/controller/song_controller.dart';

import '../models/song_model.dart';

Future<void> addSong(String _uid) async {
  int i = 1;
  try {
    await FirebaseFirestore.instance
        .collection('songs')
        .doc(_uid)
        .collection("userSongs")
        .add(
      {
        // 'id': Random(DateTime.now().second),
        'id': (Random().nextInt(100) + 1).toString(),
        "songName": "노래${i++}",
        "songGYNumber": "1111",
        "songTJNumber": "2222",
        "songJanre": "가요",
        "songUtubeAddress": "http://122.37.216.171:12345/jsy_fav/index.html",
        "songETC": "songETC",
        'timestamp': "2022년 7월 13일",
        "songOwnerId": _uid
      },
    );
  } catch (e) {
    print(e);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final songController = Get.put(SongController());
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Song List"),centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    UserCredential userCredential =
                        // await FirebaseAuth.instance.signInAnonymously();
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: "b@b.com", password: "123456");
                    String? userId = userCredential.user?.uid;
                    await addSong(userId!).then((value) => print("add song"));
                  },
                  child: Text("add Data"),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    UserCredential userCredential =
                        // await FirebaseAuth.instance.signInAnonymously();
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: "b@b.com", password: "123456");
                    String? userId = userCredential.user?.uid;
                    
                    // await getAllSongs(userId!).then((value) => print("load song"));
                  },
                  child: Text("Load data"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("List : $index"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
    Container(),
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.snowing),
          label: 'Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
