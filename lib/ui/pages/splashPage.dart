import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
