import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_karaoke_firebase/fb_data/models/song_model.dart';

class Services {
  static var client = http.Client();

  static Future<List<Song>?> fetchProducts() async {
    // var response = await client
    //     .get(Uri.parse('http://192.168.219.107/my_karaoke_db/')); // 내부 index.html
    // var response = await client
    //     .get(Uri.parse('http://122.37.216.171:12345/my_karaoke_db/loadData.php')); //외부
    var response = await client.get(
        Uri.parse('http://192.168.219.107/my_karaoke_db/loadData.php')); // 내부
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return songFromJson(jsonData);
      // print(jsonData);
    } else {
      return [];
    }
  }

  static Future deleteData({required String num}) async {
    var response = await client.put(
      Uri.parse('http://192.168.219.107/my_karaoke_db/deleteData.php?id=$num'),
    ); // 내부
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
    } else {
      return [];
    }
  }

  static Future updateData({required Song song}) async {
    var response = await client.put(
      //   Uri.parse(
      //       "http://192.168.219.107/my_karaoke_db/updateDataTest.php?id=${song.id}&songName='name_000'&songJanre='클래식'"),
      // ); // 내부
      Uri.parse(
          "http://192.168.219.107/my_karaoke_db/updateData.php?id=${song.id}&songOwnerId='${song.songOwnerId}'&songName='${song.songName}'&songGYNumber='${song.songGYNumber}'&songTJNumber='${song.songTJNumber}'&songJanre='${song.songJanre}'&songUtubeAddress='${song.songUtubeAddress}'&songETC='${song.songETC}'"),
    ); // 내부
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
    } else {
      return [];
    }
  }

  static Future putData() async {
    var response = await client.put(
      Uri.parse(
          'http://192.168.219.107/my_karaoke_db/insertData.php?songOwnerId=\'owner55\'&songName=\'maamm\'&songGYNumber=\'777\'&songTJNumber=\'888\'&songJanre=\'발라드\'&songUtubeAddress=\'utube\'&songETC=\'기타88\''),
    ); // 내부
    if (response.statusCode == 200) {
      var jsonData = response.body;
      print(jsonData);
    } else {
      return [];
    }
  }
}

List<Song> songFromJson(String str) => List<Song>.from(
      json.decode(str).map(
            (x) => fromJson(x),
          ),
    );
Song fromJson(Map<String, dynamic> json) {
  return Song(
      json["id"] ?? "1",
      json["songOwnerId"],
      json["songName"],
      json["songGYNumber"],
      json["songTJNumber"],
      json["songJanre"],
      json["songUtubeAddress"],
      json["songETC"]);
}
