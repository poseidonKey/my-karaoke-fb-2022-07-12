import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/fb_data/controller/song_controller.dart';
import '../models/stream_data.dart';
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

var songController = Get.put(SongController());

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Song List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await addSong(Song.userId!)
                        .then((value) => print("add song"));
                  },
                  child: const Text("add Data"),
                ),
                const SizedBox(
                  width: 20,
                ),
                // const Text("total 20 곡"),
                Obx(
                  () =>
                      Text("전체 ${songController.allSongs.length.toString()} 곡"),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songController.allSongs.length,
                // itemCount: 24,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Obx(() => Text(
                        "곡명 :${songController.allSongs[index].songName}")),
                    // );

                    subtitle: Obx(
                        () => Text(songController.allSongs[index].songJanre)),
                    trailing: const Icon(Icons.edit),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
    Container(
      width: 200,
      height: 200,
      color: Colors.orange,
      child: Text("Profile"),
    )
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
