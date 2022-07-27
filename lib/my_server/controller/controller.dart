import 'package:get/get.dart';
import 'package:my_karaoke_firebase/fb_data/models/song_model.dart';
import '../data/services.dart';

class ControllerServer extends GetxController {
  var songList = <Song>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var songs = await Services.fetchProducts();
    if (songs != null) {
      songList.value = songs;
      print(songList.length);
    }
  }
}
