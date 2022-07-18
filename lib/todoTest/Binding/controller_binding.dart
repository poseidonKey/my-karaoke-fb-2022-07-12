import 'package:get/get.dart';
import 'package:my_karaoke_firebase/todoTest/Controller/todo_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ToDoController>(ToDoController());
  }
}
