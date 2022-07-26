import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/my_server/data/services.dart';
import 'package:my_karaoke_firebase/my_server/views/home_page_server.dart';
import 'package:my_karaoke_firebase/sql/add_edit_screen.dart';
import 'package:my_karaoke_firebase/sql/search_page.dart';
import 'package:my_karaoke_firebase/sql/song_list.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/janre_page.dart';
import '../todoTest/Screens/all_notes.dart';

enum Janre { POP, KARAOKE, BALLADE, TROTS, CLASSIC, FAVORITY }

class SQLHome extends StatelessWidget {
  const SQLHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('폰 내부 데이터'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: "곡명으로 찾기",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) {
                      return const SearchPage();
                    },
                    fullscreenDialog: true),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Get.to(() => AllNotes());
            },
            tooltip: "원격데이터로 이동",
            icon: const Icon(Icons.network_check_sharp),
          ),
          IconButton(
            onPressed: () async {
              return _showPopupMenu(context);
            },
            tooltip: "장르별 곡 찾기",
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        backgroundColor: Colors.amber,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const DrawerHeader(
                child: Text(
                  "데이터 관리",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                  title: const Text("자체 서버 데이터"),
                  onTap: (() {
                    Get.to(() => HomePageServer());
                    // Get.back();
                  })),
              ListTile(
                  title: const Text("외부 데이터 가져오기"),
                  onTap: (() {
                    Get.back();
                  })),
              ListTile(
                  title: const Text("모든 곡 삭제"),
                  onTap: (() {
                    Get.back();
                  })),
              ListTile(
                  title: const Text("서버로 업로드"),
                  onTap: (() {
                    Get.back();
                  })),
              ListTile(
                  title: const Text("데이터 백업"),
                  onTap: (() {
                    Get.back();
                  })),
              ListTile(
                  title: const Text("데이터 복원"),
                  onTap: (() {
                    Get.back();
                  })),
              const Divider(
                height: 10,
                thickness: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("닫기"))
            ],
          ),
        ),
      ),
      body: const SongList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddEditPage(isNew: true),
          );
        },
        child: const Icon(Icons.add),
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
            value: "발라드",
            child: ListTile(
              leading: Icon(Icons.note_add),
              title: Text('발라드'),
            ),
          ),
          const PopupMenuItem(
            value: '가요',
            child: ListTile(
              leading: Icon(Icons.note_add),
              title: Text('가요'),
            ),
          ),
          const PopupMenuItem(
            value: 'pop',
            child: ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Pop'),
            ),
          ),
          const PopupMenuItem(
            value: '트롯',
            child: ListTile(
              leading: Icon(Icons.pages),
              title: Text('트롯'),
            ),
          ),
          const PopupMenuItem(
            value: "클래식",
            child: ListTile(
              leading: Icon(Icons.pages),
              title: Text('Classic'),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: '즐겨찾기',
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

  void selectedMenu(BuildContext context, String selectedJanre) {
    String _janre = "";
    switch (selectedJanre) {
      case "pop":
        _janre = "pop";
        break;
      case "가요":
        _janre = "가요";
        break;
      case "발라드":
        _janre = "발라드";
        break;
      case "클래식":
        _janre = "클래식";
        break;
      case "트롯":
        _janre = "트롯";
        break;
      case "즐겨찾기":
        _janre = "즐겨찾기";
        break;
      default:
    }
    Get.to(
      JanrePage(
        searchJanre: _janre,
      ),
    );
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
}
