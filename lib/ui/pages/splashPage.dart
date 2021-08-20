import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    //TODO Проверка на авторизацию, загрузка домашней страницы либо WelcomePage
    return WelcomePage();
  }
}
