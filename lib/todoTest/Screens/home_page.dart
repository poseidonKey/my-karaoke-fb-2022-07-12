import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/BottomNavBar/bnb_controller.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/search_notes.dart';
import 'all_notes.dart';
import 'edit_delete_notes.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  BNBController bnbController = Get.put(BNBController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: bnbController.tabIndex.value,
          children: [
            AllNotes(),
            SearchNotes(),
            EditDeleteNotes(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lightBlueAccent.shade100,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.blueGrey,
          elevation: 3,
          onTap: bnbController.changeTabIndex,
          currentIndex: bnbController.tabIndex.value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.noteSticky), label: '모든 곡'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.magnifyingGlass), label: '곡 찾기'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.penToSquare), label: '곡 정보 수정'),
          ],
        ),
      ),
    );
  }
}
