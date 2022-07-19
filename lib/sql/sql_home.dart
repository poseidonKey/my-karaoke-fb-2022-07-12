import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/sql/add_edit_screen.dart';
import 'package:my_karaoke_firebase/sql/search_page.dart';
import 'package:my_karaoke_firebase/sql/song_list.dart';

class SQLHome extends StatelessWidget {
  const SQLHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL DB용'),
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
}
