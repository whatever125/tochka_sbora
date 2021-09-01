import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<dynamic> loggedIn;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return WelcomePage();
    } else {
      return HomePage();
    }
  }
}
