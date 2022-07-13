import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        'timestamp': DateTime.now(),
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
  final List<Widget> _pages = [
    Center(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
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
            ElevatedButton(
              onPressed: () async {
                UserCredential userCredential =
                    // await FirebaseAuth.instance.signInAnonymously();
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: "b@b.com", password: "123456");
                String? userId = userCredential.user?.uid;
                await getAllSongs(userId!).then((value) => print("load song"));
              },
              child: Text("Load data"),
            ),
          ],
        ),
      ),
    ),
    Container(),
  ];
  int _selectedIndex = 0;

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

Future<void> getAllSongs(String userId) async {
  List<Song> allSongs = [];
  try {
    QuerySnapshot userSongsSnapshot = await FirebaseFirestore.instance
        .collection('songs')
        .doc(userId)
        .collection("userSongs")
        .orderBy("timestamp", descending: true)
        .get();
    List<Object> songs = userSongsSnapshot.docs.map(
      (songDoc) {
        Map<String, dynamic> t = songDoc.data() as Map<String, dynamic>;
        // print('=======> ${t["id"]}');
        // print('=======>>>>>> ${t["songName"]}');
        // return Song.fromDoc(songDoc.data() );
        // print(songDoc.data());
        // Map<String, dynamic> m = {};
        // m.addAll(songDoc.data());

        // print(m[0]);
        // return songDoc.data()!;
        return t;
      },
    ).toList();
    // Song.fromDoc(songs[0].toString());
    // print("songs 0 : ${songs[0].toString()}");
    print(">>>>길이 : ${songs.length}");
    for (var i = 0; i < songs.length; i++) {
      Map<String, dynamic> t = songs[i] as Map<String, dynamic>;

      Song song = Song.fromMap(t);
      allSongs.add(song);
      print(t["id"]);
      // print(songs[i].toString());
      // Song t = Song.fromDoc(songs[i]);
      // print(t.songID);
    }
  } catch (e) {
    print(e);
  }
}
