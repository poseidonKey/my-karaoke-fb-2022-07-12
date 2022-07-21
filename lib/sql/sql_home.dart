import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/sql/add_edit_screen.dart';
import 'package:my_karaoke_firebase/sql/search_page.dart';
import 'package:my_karaoke_firebase/sql/song_list.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/janre_page.dart';

enum Janre { POP, BALLADE, TROTS, CLASSIC, FAVORITY }

class SQLHome extends StatelessWidget {
  const SQLHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내부 DB'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded),
            tooltip: "Favorite",
          ),
          IconButton(
            onPressed: () {
              Get.to(() => const SQLHome());
            },
            icon: const Icon(Icons.data_array_outlined),
            tooltip: "MySQL",
          ),
          IconButton(
            onPressed: () async {
              return _showPopupMenu(context);
            },
            tooltip: "Menu보기",
            icon: const Icon(Icons.menu),
          ),
        ],
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
    Get.to(
      JanrePage(
        searchJanre: Janre.CLASSIC.toString(),
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
