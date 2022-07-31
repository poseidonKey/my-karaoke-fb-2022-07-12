import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/sql/song_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFileRepository extends StatefulWidget {
  const LocalFileRepository({Key? key}) : super(key: key);

  @override
  State<LocalFileRepository> createState() => _LocalFileRepositoryState();
}

class _LocalFileRepositoryState extends State<LocalFileRepository> {
  List<SongItem> songsList = [];
  void initData() async {
    var result = await readListFile();
    setState(() {
      songsList.addAll(result);
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('텍스트 파일 이용'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              songsList[index].id!,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(
                              "번,  ${songsList[index].songName}",
                              style: const TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: songsList.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dir = await getApplicationDocumentsDirectory();
          bool fileExist = await File("${dir.path}/songs.txt").exists();
          // print(fileExist);
          if (fileExist) {
            await File("${dir.path}/songs.txt").delete();
            Get.defaultDialog(
                title: "이전 데이터 삭제!!",
                content: const Text("앱을 다시 실행해 주세요."),
                actions: [
                  ElevatedButton(
                      onPressed: () => Get.back(), child: const Text("확인")),
                ]);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void writeFruit(String song) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File('${dir.path}/songs.txt').readAsString();
    file = '$file\n$song';
    File('${dir.path}/songs.txt').writeAsStringSync(file);
  }

  Future<List<SongItem>> readListFile() async {
    List<SongItem> itemList = [];
    var key = "first";
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File("${dir.path}/songs.txt").exists();
    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context)
          .loadString("local_repository/songs.txt");
      File("${dir.path}/songs.txt").writeAsStringSync(file);

      return itemList = await stringAsArray(file);
    } else {
      var file = await File("${dir.path}/songs.txt").readAsString();
      return itemList = await stringAsArray(file);
    }
  }

  Future<List<SongItem>> stringAsArray(String file) async {
    var array = file.split("\n");
    List<SongItem> songs = [];
    for (var items in array) {
      var contents = items.split(",");
      var data = [];
      for (var i = 0; i < contents.length; i++) {
        data.add(contents[i]);
      }
      var song = SongItem(
        data[0],
        data[1],
        data[2],
        data[3],
        data[4],
        data[5],
        data[6],
        data[7],
        data[8],
      );
      data.clear();
      songs.add(song);
    }
    return songs;
  }
}
