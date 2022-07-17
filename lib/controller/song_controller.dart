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
      int i = 0;
      for (var detail in details) {
        // print("data : ${data.docs[i].id}");
        detail.id = data.docs[i].id;
        // print("after : ${detail.id}");
        i++;
        allSongs.add(detail);
        // update();
      }
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
