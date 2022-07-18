import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/todoTest/Model/song_model.dart';

class ToDoController extends GetxController {
  var isLoading = false;
  var todoList = <SongModel>[];
  var searchList = [].obs;

  Future<void> addToData(
    String songName,
    String id,
    String songGYNumber,
    String songTJNumber,
    String songJanre,
    String songUtubeAddress,
    String songETC,
    bool songFavorite,
  ) async {
    await FirebaseFirestore.instance
        .collection('todos')
        // .doc("ALXyp4TcnKeefbKcgq9emzH43z12")
        .doc(SongModel.userId)
        .collection("todoDatas")
        .doc((id != '' ? id : null)) //자동 생성
        .set(
      {
        "songName": songName,
        "songGYNumber": songGYNumber,
        "songTJNumber": songTJNumber,
        "songJanre": songJanre,
        "songUtubeAddress": songUtubeAddress,
        "songETC": songETC,
        "songFavorite": songFavorite,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todos')
          .doc(SongModel.userId)
          .collection("todoDatas")
          .orderBy("songName")
          .get();
      todoList.clear();
      for (var item in _taskSnap.docs) {
        todoList.add(
          SongModel(
            item.id,
            item["songName"],
            item["songGYNumber"],
            item["songTJNumber"],
            item["songJanre"],
            item["songUtubeAddress"],
            item["songETC"],
            item["songFavorite"],
          ),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar("Error", "$e.toString()");
    }
  }

  void delete(String id) {
    FirebaseFirestore.instance
        .collection('todos')
        .doc(SongModel.userId)
        .collection("todoDatas")
        .doc(id)
        .delete();
  }

  Future queryData(String q) async {
    return FirebaseFirestore.instance
        .collection('todos')
        .doc(SongModel.userId)
        .collection("todoDatas")
        .where('task', isGreaterThanOrEqualTo: q)
        .get();
  }
}
