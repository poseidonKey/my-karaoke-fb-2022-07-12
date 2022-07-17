import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/song_model.dart';

class SongController extends GetxController {
  var allSongs = <Song>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getDetailsList("ALXyp4TcnKeefbKcgq9emzH43z12");
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
      details = data.docs.map((document) {
        // print(document);
        return Song.fromMap(document);
      }).toList();
      int i = 0;
      // print(">>>>>>>>>>>>>>> $details");
      for (var detail in details) {
        // print("data : ${data.docs[i].id}");
        detail.id = data.docs[i].id;
        // print("after : ${detail.id}");
        i++;
        allSongs.clear();
        allSongs(RxList(details));
      }
    } catch (e) {
      print(e);
    }
  }
}
