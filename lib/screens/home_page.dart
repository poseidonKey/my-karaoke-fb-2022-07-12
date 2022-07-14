import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/controller/song_controller.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var songController = Get.put(SongController());
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
                const Text("total 20 곡"),
                // Obx(
                //   () {
                //     // return Text("total ${songController.allSongs.length} 곡");
                //     return const Text("total 20 곡");
                //   },
                // ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: const Text("Load data"),
                // ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder<List<Song>>(
                stream: streamMessages(), //중계하고 싶은 Stream을 넣는다.
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    //데이터가 없을 경우 로딩위젯을 표시한다.
                    return const Center(child: CircularProgressIndicator());
                  } else if (asyncSnapshot.hasError) {
                    return const Center(
                      child: Text('오류가 발생했습니다.'),
                    );
                  } else {
                    List<Song> messages =
                        asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(messages[index].id),
                                child: ListTile(
                                  leading: const Icon(Icons.favorite),
                                  title: Text(messages[index].songName),
                                  subtitle: Text(messages[index].songJanre),
                                  trailing: const Icon(Icons.edit),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
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
