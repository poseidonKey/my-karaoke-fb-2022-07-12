import 'package:get/get.dart';
import 'package:my_karaoke_firebase/models/song_model.dart';

import '../data/services.dart';

class Controller extends GetxController{
  var productList = <Song>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async{
   var products = await Services.fetchProducts();
   if(products !=null){
     productList.value = products;
   }
  }
}