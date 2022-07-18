// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/todoTest/Binding/controller_binding.dart';
import 'package:my_karaoke_firebase/todoTest/OnBoarding/views.dart';
import 'package:my_karaoke_firebase/todoTest/Screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
      title: 'Song-manage App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute:
          initScreen == 0 || initScreen == null ? 'OnBoardingPage' : 'HomePage',
      routes: {
        'OnBoardingPage': (context) => OnboardingPage(),
        'HomePage': (context) => HomePage(),
      },
      initialBinding: ControllerBinding(),
    );
  }
}
