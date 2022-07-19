import 'package:get/get.dart';
import 'package:my_karaoke_firebase/sql/song_item.dart';

class SongItemController {
  Rx<SongItem> songItem =
      SongItem(null, 'aa', 'aa', 'aa', 'aa', 'aa', 'aa', 'aa', 'true').obs;
  void songItemUpdate(SongItem si){
    songItem(si);
  }
}
