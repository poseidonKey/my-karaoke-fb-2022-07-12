import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_karaoke_firebase/models/song_model.dart';
import 'package:my_karaoke_firebase/screens/home_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static const String routeName = 'signin-page';

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _fKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String _email, _password;
  void _submit(BuildContext context) async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    if (!_fKey.currentState!.validate()) return;
    _fKey.currentState!.save();
    // print('email: $_email, password: $_password');
    try {
      var isLogin = await isAuthenticated(_email, _password);
      // print(isLogin);
      if (isLogin) {
        Song.userId = userId!;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage(uid: userId!)));
        // Get.to(HomePage(uid: userId!));
      } else {
        _fKey.currentState!.reset();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthProvider>().state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Songs',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _fKey,
                autovalidateMode: autovalidateMode,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (String? val) {
                          // if (val!.trim().contains('@')) {
                          //   return 'Invalid email';
                          // }
                          return null;
                        },
                        onSaved: (val) => _email = val!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.security),
                        ),
                        validator: (String? val) {
                          if (val!.trim().length < 6) {
                            return 'Password must be at least 6 long';
                          }
                          return null;
                        },
                        onSaved: (val) => _password = val!,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        return _submit(context);
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'No account? Sign Up!',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> isAuthenticated(_email, _password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password);
    userId = userCredential.user?.uid;
    if (userId != null) {
      return true;
    }
    return false;
  }

  String? userId;
}
