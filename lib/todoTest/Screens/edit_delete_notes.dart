import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Controller/todo_controller.dart';

class EditDeleteNotes extends StatelessWidget {
  EditDeleteNotes({Key? key}) : super(key: key);
  ToDoController todo = Get.put(ToDoController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToDoController>(
        init: ToDoController(),
        initState: (_) {},
        builder: (todo) {
          todo.getData();
          return Scaffold(
            backgroundColor: Color.fromRGBO(194, 184, 255, 1),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Color.fromRGBO(54, 115, 125, 1),
              title: Text("Edit and Delete To-Do"),
            ),
            body: Center(
                child: todo.isLoading
                    ? SizedBox(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: todo.todoList.length,
                        itemBuilder: (BuildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  todo.todoList[index].songName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await addEditDelete(
                                            todo,
                                            'Edit',
                                            todo.todoList[index].id,
                                            todo.todoList[index].songName,
                                            todo.todoList[index].songGYNumber,
                                            todo.todoList[index].songTJNumber,
                                            todo.todoList[index].songJanre,
                                            todo.todoList[index]
                                                .songUtubeAddress,
                                            todo.todoList[index].songETC,
                                            !todo.todoList[index].songFavorite,
                                          );
                                          Get.snackbar(
                                              '${todo.todoList[index].songName}',
                                              "Updated",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor:
                                                  Colors.teal.shade100,
                                              margin: EdgeInsets.only(
                                                  bottom: 18,
                                                  left: 10,
                                                  right: 10));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.blue,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          todo.delete(todo.todoList[index].id);
                                          Get.snackbar(
                                              '${todo.todoList[index].songName}',
                                              "Successfully deleted",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor:
                                                  Colors.teal.shade100,
                                              margin: EdgeInsets.only(
                                                  bottom: 18,
                                                  left: 10,
                                                  right: 10));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.deleteLeft,
                                          color: Colors.pink,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        })),
          );
        });
  }

  addEditDelete(
    ToDoController toDoController,
    String title,
    String id,
    String songName,
    String songGYNumber,
    String songTJNumber,
    String songJanre,
    String songUtubeAddress,
    String songETC,
    bool songFavorite,
  ) async {
    if (songName.isNotEmpty) {
      _textEditingController.text = songName;
    }
    await Get.defaultDialog(
      title: title,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Insert valid input";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async => await todo.addToData(
                  _textEditingController.text.trim(),
                  id,
                  "곡명 : 테스트",
                  "1111",
                  "2222",
                  "잉이이ㅣ이이",
                  "기타사항",
                  false),
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
