import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/todoTest/Model/todo_model.dart';

class ToDoController extends GetxController {
  var isLoading = false;
  var todoList = <ToDoModel>[];
  var searchList = [].obs;

  Future<void> addToD(String task, bool done, String id) async {
    await FirebaseFirestore.instance
        .collection('todos')
        .doc((id != '' ? id : null)) //자동 생성
        .set({'task': task, 'isDone': done}, SetOptions(merge: true)).then(
            (value) => Get.back());
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todos')
          .orderBy('task')
          .get();
      todoList.clear();
      for (var item in _taskSnap.docs) {
        todoList.add(
          ToDoModel(item['task'], item['isDone'], item.id),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      Get.snackbar("Error", "${e.toString()}");
    }
  }

  void delete(String id) {
    FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }

  Future queryData(String q) async {
    return FirebaseFirestore.instance
        .collection('todos')
        .where('task', isGreaterThanOrEqualTo: q)
        .get();
  }
}