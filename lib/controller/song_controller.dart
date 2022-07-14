import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/song_model.dart';

class SongController extends GetxController {
  var allSongs = <Song>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllSongs("ALXyp4TcnKeefbKcgq9emzH43z12");
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
