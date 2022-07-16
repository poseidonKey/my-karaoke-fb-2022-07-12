import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/models/stream_data.dart';
import '../models/song_model.dart';

class SongController extends GetxController {
  var allSongs = <Song>[].obs;
  List<Song> tmp = [];
  @override
  void onInit() {
    super.onInit();
    var songs = streamMessages();
    songs.forEach((element) {
      tmp.addAll(element);
      // print(element[1].id);
      // print(allSongs[1].id);
      // allSongs.add(element);
    });
    dataCompleted();
    // getAllSongs("ALXyp4TcnKeefbKcgq9emzH43z12");
  }

  void dataCompleted() {
    allSongs.clear();
    allSongs = RxList(tmp);
    update();
  }

  Future<void> getAllSongs(String userId) async {
    try {
      QuerySnapshot userSongsSnapshot = await FirebaseFirestore.instance
          .collection('songs')
          .doc(userId)
          .collection("userSongs")
          // .orderBy("timestamp", descending: true)
          .get();
      // List<Song> songs = userSongsSnapshot.docs.map(
      //   (songDoc) {
      //     // Map<String, dynamic> song = songDoc.data() as Map<String, dynamic>;
      //     // return fromMap(song);
      //     // return song;
      //     return Song.fromDoc(songDoc);
      //   },
      // ).toList();
      // Song.fromDoc(songs[0].toString());
      // print("songs 0 : ${songs[0].toString()}");
      // print(">>>>길이 : ${songs.length}");
      // // for (var i = 0; i < songs.length; i++) {
      // //   Map<String, dynamic> t = songs[i] as Map<String, dynamic>;
      // //   Song song = fromMap(t);
      // //   allSongs.add(song);
      // // }
      // allSongs = RxList(songs);
    } catch (e) {
      print(e);
    }
  }
}
