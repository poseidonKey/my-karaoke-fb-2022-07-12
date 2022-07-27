import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/my_server/controller/controller.dart';
import 'package:my_karaoke_firebase/my_server/data/services.dart';
import 'package:my_karaoke_firebase/my_server/views/add_edit_server.dart';
import 'package:my_karaoke_firebase/my_server/views/song_tile.dart';
import 'package:my_karaoke_firebase/sql/sql_home.dart';

class HomePageServer extends StatelessWidget {
  HomePageServer({Key? key}) : super(key: key);
  final controllerServer = Get.put(ControllerServer());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('애창곡 : Server'),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => const SQLHome());
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Services.putData();
            },
            icon: const Icon(Icons.access_alarm),
          ),
          IconButton(
            onPressed: () {
              Get.to(
                () => const AddEditServer(isNew: true, songItem: null),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return SongTile(
                song: controllerServer.songList[index],
              );
            },
            itemCount: controllerServer.songList.length,
          ),
        ),
      ),
    );
  }
}
