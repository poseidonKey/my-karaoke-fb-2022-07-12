import 'package:flutter/material.dart';
import 'package:my_karaoke_firebase/todoTest/Model/song_model.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("song view"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${song.id}"),
            Text("${song.songName}"),
            Text("${song.songGYNumber}"),
          ],
        ),
      ),
    );
  }
}
