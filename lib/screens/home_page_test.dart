import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/song_controller.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var songController = Get.put(SongController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Song List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  songController
                      .addSong("ALXyp4TcnKeefbKcgq9emzH43z12")
                      .then((value) => print("add song"));
                  // await addSong(Song.userId!)
                  //     .then((value) => print("add song"));
                },
                child: const Text("add Data"),
              ),
              const SizedBox(
                width: 20,
              ),
              // const Text("total 20 곡"),
              Obx(
                () => Text("전체 ${songController.allSongs.length.toString()} 곡"),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songController.allSongs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.favorite),
                  // title: Text(">>> : $index"),
                  title: Obx(() =>
                      Text("곡명 :${songController.allSongs[index].songName}")),

                  subtitle:
                      Obx(() => Text(songController.allSongs[index].id ?? "")),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    print(songController.allSongs[index].id);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
