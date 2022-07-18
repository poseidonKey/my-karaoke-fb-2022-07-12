import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Controller/todo_controller.dart';

class SearchNotes extends StatelessWidget {
  SearchNotes({Key? key}) : super(key: key);
  ToDoController todo = Get.put(ToDoController());
  TextEditingController textEditingController = TextEditingController();
  QuerySnapshot? snapshot;
  RxBool ex = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: const Color.fromRGBO(232, 245, 182, 1),
          appBar: AppBar(
            toolbarHeight: 70,
            leading: const Text(""),
            backgroundColor: const Color.fromRGBO(54, 115, 125, 1),
            title: Card(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search To-Do',
                  border: InputBorder.none,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                onChanged: (value) {},
              ),
            ),
            actions: [
              GetBuilder<ToDoController>(
                  init: ToDoController(),
                  builder: (val) {
                    return IconButton(
                        onPressed: () {
                          val
                              .queryData(textEditingController.text)
                              .then((value) {
                            snapshot = value;
                            ex.toggle();
                          });
                        },
                        icon: const Icon(Icons.search));
                  })
            ],
          ),
          body: ex.value
              ? ListView.builder(
                  itemCount: snapshot!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Text(
                        '${snapshot!.docs[index]['task']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  })
              : Container(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              ex.value = false;
            },
            child: const Icon(FontAwesomeIcons.trashCanArrowUp),
          ),
        ));
  }
}
