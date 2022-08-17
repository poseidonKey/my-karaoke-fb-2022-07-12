import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/fb_data/screens/signin_page.dart';
import 'package:my_karaoke_firebase/sql/sql_home.dart';
import 'package:my_karaoke_firebase/todoTest/Controller/todo_controller.dart';
import 'package:my_karaoke_firebase/todoTest/Model/song_model.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/detail_view.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/janre_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Janre { POP, BALLADE, TROTS, CLASSIC, FAVORITY }

class AllNotes extends StatelessWidget {
  AllNotes({
    Key? key,
  }) : super(key: key);
  final ToDoController todo = Get.put(ToDoController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ToDoController>(
        init: ToDoController(),
        initState: (_) {},
        builder: (todo) {
          // todo.getData();
          return Scaffold(
            backgroundColor: const Color.fromRGBO(245, 182, 201, 1),
            appBar: AppBar(
              leading: Text(
                "총 ${todo.todoList.length.toString()} 곡",
                style: const TextStyle(fontSize: 16, color: Colors.yellow),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_outline_rounded),
                  tooltip: "Favorite",
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => const SQLHome());
                  },
                  icon: const Icon(Icons.data_array),
                  tooltip: "MySQL",
                ),
                IconButton(
                  onPressed: () async {
                    return _showPopupMenu(context);
                  },
                  tooltip: "Menu보기",
                  icon: const Icon(Icons.more_vert),
                ),
                IconButton(
                  onPressed: () async {
                    return isSignOut();
                  },
                  tooltip: "Logout",
                  icon: const Icon(Icons.logout),
                )
              ],
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(54, 115, 125, 1),
              title: const Text("나의 애창곡"),
            ),
            body: Center(
              child: todo.isLoading
                  ? const SizedBox(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemCount: todo.todoList.length,
                      itemBuilder: (buildContext, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: Row(
                            children: [
                              IconButton(
                                iconSize: 30,
                                onPressed: () async {
                                  // print(todo.todoList[index].id);
                                  await todo.addToData(
                                    todo.todoList[index].songName,
                                    todo.todoList[index].id,
                                    todo.todoList[index].songGYNumber,
                                    todo.todoList[index].songTJNumber,
                                    todo.todoList[index].songJanre,
                                    todo.todoList[index].songUtubeAddress,
                                    todo.todoList[index].songETC,
                                    !todo.todoList[index].songFavorite,
                                  );
                                  Get.snackbar(
                                      "${todo.todoList[index].songName}",
                                      "Favorite",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.teal.shade100,
                                      margin: const EdgeInsets.only(
                                          bottom: 18, left: 10, right: 10));
                                },
                                icon: Icon(
                                    (todo.todoList[index].songFavorite == true)
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    todo.todoList[index].songName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(todo.todoList[index].id),
                                  trailing: IconButton(
                                    onPressed: () {
                                      todo.delete(todo.todoList[index].id);
                                      Get.snackbar(
                                        todo.todoList[index].songName,
                                        "Successfully deleted",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.teal.shade100,
                                        margin: const EdgeInsets.only(
                                            bottom: 18, left: 10, right: 10),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                  ),
                                  onTap: () {
                                    Get.to(
                                      () => DetailView(
                                          song: todo.todoList[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.black,
                          indent: 25,
                          endIndent: 25,
                          thickness: 1,
                        );
                      },
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                await addEditDelete(todo, '곡 추가하기', "");
                Get.snackbar('Great!', "추가 됐습니다.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.teal.shade100,
                    margin:
                        const EdgeInsets.only(bottom: 18, left: 10, right: 10));
              },
              child: const Icon(FontAwesomeIcons.plus),
            ),
          );
        });
  }

  Future<void> addEditDelete(
      ToDoController toDoController, String title, String id) async {
    _textEditingController.text = "";
    await Get.defaultDialog(
      title: title,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              validator: (value) {
                if (value == null || value.isEmpty || value == "") {
                  return "Insert valid input";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await toDoController
                    .addToData(
                      _textEditingController.text.trim(),
                      id,
                      "33333",
                      "1111",
                      "발라드",
                      "잉이이ㅣ이이",
                      "기타사항",
                      false,
                    )
                    .then((value) => Get.off(AllNotes())); //  .back());
              },
              child: const Text("저장!"),
            )
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    String? selected = await showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(
            MediaQuery.of(context).size.width / 2 + 50,
            MediaQuery.of(context).size.height / 5,
            100,
            100),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem(
            value: '발라드',
            child: ListTile(
              leading: Icon(Icons.note_add),
              title: Text('발라드'),
            ),
          ),
          const PopupMenuItem(
            value: 'Pop',
            child: ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Pop'),
            ),
          ),
          const PopupMenuItem(
            value: 'trots',
            child: ListTile(
              leading: Icon(Icons.pages),
              title: Text('trots'),
            ),
          ),
          const PopupMenuItem(
            value: "classic",
            child: ListTile(
              leading: Icon(Icons.pages),
              title: Text('Classic'),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: 'favorite',
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text('즐겨찾기'),
            ),
          )
        ]);
    if (selected == null) {
      return;
    }
    selectedMenu(context, selected);
  }

  void selectedMenu(BuildContext context, String selectedMenu) {
    // Get.to(const JanrePage());
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       // ignore: prefer_const_constructors
    //       title: Text('Selected'),
    //       content: Text('$selectedMenu 보여주기.'),
    //       actions: [],
    //     );
    //   },
    // );
  }

  Future<void> isSignOut() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString("userId", "ALXyp4TcnKeefbKcgq9emzH43z12");
    await prefs.remove("userId");
    SongModel.userId = "";
    Get.to(() => const SigninPage()); //   .to(const SigninPage());
  }
}
