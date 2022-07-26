import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_karaoke_firebase/models/song_model.dart';

class Services {
  static var client = http.Client();

  static Future<List<Song>?> fetchProducts() async {
    // var response = await client
    //     .get(Uri.parse('http://122.37.216.171:12345/my_karaoke_db/')); //외부
    var response = await client
        .get(Uri.parse('http://192.168.219.107/my_karaoke_db/')); // 내부

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return songFromJson(jsonData);
      // print(jsonData);
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
