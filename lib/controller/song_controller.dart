import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/song_model.dart';

class SongController extends GetxController {
  var allSongs = <Song>[
    Song(
      "aa",
      "aa",
      "aa",
      "aa",
      "aa",
      "aa",
      "aa",
      "aa",
    )
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    await getDetailsList("ALXyp4TcnKeefbKcgq9emzH43z12");
    delItem();
    // ever(allSongs, () => print("ever"));
  }

  void delItem() {
    allSongs.removeAt(0);
  }

  Future<void> addSong(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('songs')
          .doc(uid)
          .collection("userSongs")
          .add(
        // {
        //   "id": Song("id", "songOwnerId", "songName", "songGYNumber",
        //       "songTJNumber", "songJanre", "songUtubeAddress", "songETC"),
        // },
        // );
        {
          // 'id': Random(DateTime.now().second),
          'id': (Random().nextInt(100) + 1).toString(),
          "songName": "노래${Random().nextInt(100) + 1}",
          "songGYNumber": "1111",
          "songTJNumber": "2222",
          "songJanre": "가요",
          "songUtubeAddress": "http://122.37.216.171:12345/jsy_fav/index.html",
          "songETC": "songETC",
          'timestamp': "2022년 7월 13일",
          "songOwnerId": uid
        },
      );
      allSongs.clear();
      await getDetailsList("ALXyp4TcnKeefbKcgq9emzH43z12");
    } catch (e) {
      print(e);
    }
  }

  Future getDetailsList(String uid) async {
    List<Song> details = [];
    try {
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .doc(uid)
          .collection("userSongs")
          .get();
      // print("${data}");
      // details = data.docs.map((document) {
      // allSongs.clear();
      details = data.docs.map((document) {
        // print(document);
        return Song.fromMap(document);
      }).toList();
      // int i = 0;
      // for (var detail in details) {
      //   // print("data : ${data.docs[i].id}");
      //   detail.id = data.docs[i].id;
      //   // print("after : ${detail.id}");
      //   i++;
      //   allSongs.add(detail);
      //   // update();
      // }
      allSongs.value = details;
      // allSongs.removeAt(0);

      // allSongs.addAll(RxList(data.docs.map((document) {
      //   // print(document);
      //   return Song.fromMap(document);
      // }).toList()));
      // print(">>>>>>>>>>>>>>> $details");
      // return details;
      // if (details != null)
      // else
      //   return [];
      // allSongs.clear();
      // allSongs.value = RxList(details);
    } catch (e) {
      print(e);
    }
  }
}
