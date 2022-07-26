import 'package:http/http.dart' as http;
import 'package:my_karaoke_firebase/models/song_model.dart';

class Services{
  static var client = http.Client();

  static Future<List<Song>?> fetchProducts() async{
    // var response = await client.get(Uri.parse('https://makeup-api.herokuapp.com'
    //     '/api/v1/products.json?brand=maybelline'));
    var response = await client.get(Uri.parse('http://192.168.219.107/my_karaoke_db/'));

    if(response.statusCode == 200){
       var jasonData = response.body;
      //  return productFromJson(jasonData);
      print(jasonData);
    }else{
      return null;
    }
  }
}