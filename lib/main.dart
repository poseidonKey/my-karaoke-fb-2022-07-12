// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/fb_data/screens/signin_page.dart';
import 'package:my_karaoke_firebase/local_repository/local_file_repository.dart';
import 'package:my_karaoke_firebase/todoTest/Binding/controller_binding.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sql/sql_home.dart';

String? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initScreen = await Get.find<SharedPreferences>().getString("userId");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getString("userId"); // .getInt("initScreen");
  print('initScreen $initScreen');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
      title: 'Song-manage App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      // initialRoute: initScreen == "" || initScreen == null
      //     ? 'OnBoardingPage'
      //     : 'HomePage',
      // routes: {
      //   // 'OnBoardingPage': (context) => OnboardingPage(),
      //   'OnBoardingPage': (context) => const SigninPage(),
      //   'HomePage': (context) => HomePage(),
      // },
      initialBinding: ControllerBinding(),
      // home: const SQLHome(),
      home: const LocalFileRepository(),
      // home: const SigninPage(),
    );
  }
}
