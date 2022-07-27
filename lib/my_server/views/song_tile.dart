import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/models/song_model.dart';
import 'package:my_karaoke_firebase/my_server/views/add_edit_server.dart';

class SongTile extends StatelessWidget {
  SongTile({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 75,
                    width: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text("제목: ${song.songName}"),
                  ),
                  Positioned(
                    top: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.red,
                        onPressed: () {
                          Get.to(
                            () => AddEditServer(
                              isNew: false,
                              songItem: song,
                            ),
                          );
                        },
                        iconSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                "분류 : ${song.songJanre}",
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
