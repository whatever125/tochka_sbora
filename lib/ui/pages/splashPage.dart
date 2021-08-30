import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late dynamic _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<dynamic> loggedIn;

  @override
  void initState() {
    super.initState();
    onRefresh(_auth.currentUser);
  }

  void onRefresh(userCredentials) {
    setState(() {
      _user = userCredentials;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return WelcomePage();
    } else {
      return HomePage();
    }
  }
}
