import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFileRepository extends StatefulWidget {
  const LocalFileRepository({Key? key}) : super(key: key);

  @override
  State<LocalFileRepository> createState() => _LocalFileRepositoryState();
}

class _LocalFileRepositoryState extends State<LocalFileRepository> {
  List<String> songSList = [];
  TextEditingController controller = TextEditingController();
  void initData() async {
    var result = await readListFile();
    setState(() {
      songSList.addAll(result);
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
        title: const Text('텍스트 파일'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(
                          songSList[index],
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                  itemCount: songSList.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeFruit(controller.value.text);
          setState(() {
            songSList.add(controller.value.text);
          });
          controller.text = "";
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void writeFruit(String song) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File('${dir.path}/songs.txt').readAsString();
    file = '$file\n$song';
    File('${dir.path}/fruit.txt').writeAsStringSync(file);
  }

  Future<List<String>> readListFile() async {
    List<String> itemList = [];
    var key = "first";
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File("${dir.path}/songs.txt").exists();
    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context)
          .loadString("local_repository/songs.txt");
      File("${dir.path}/fruit.txt").writeAsStringSync(file);

      return itemList = stringAsArray(file, itemList);
    } else {
      var file = await File("${dir.path}/songs.txt").readAsString();
      // var array = file.split("\n");
      // for (var item in array) {
      //   print(item);
      //   itemList.add(item);
      // }
      return itemList = stringAsArray(file, itemList);
    }
  }

  List<String> stringAsArray(String file, List<String> list) {
    var array = file.split("\n");
    for (var item in array) {
      print(item);
      list.add(item);
    }
    return list;
  }
}
