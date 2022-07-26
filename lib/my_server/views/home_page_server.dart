import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/my_server/controller/controller.dart';
import 'package:my_karaoke_firebase/my_server/views/song_tile.dart';

class HomePageServer extends StatelessWidget {
  HomePageServer({Key? key}) : super(key: key);
  final controllerServer = Get.put(ControllerServer());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('애창곡 Server'),
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.view_list_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Obx(
            () => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                // return Text("aa");
                return SongTile(
                  song: controllerServer.songList[index],
                );
              },
              itemCount: controllerServer.songList.length,
            ),
          ),
        ),
      ),
    );
  }
}
