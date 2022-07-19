import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      return Container();
                      //SearchPage();
                    },
                    fullscreenDialog: true),
              );
            },
          ),
        ],
      ),
      body: Container(), //SongList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Container() //          AddEditPage(isNew: true),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
