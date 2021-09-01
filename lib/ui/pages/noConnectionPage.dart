import 'package:flutter/material.dart';

class NoConnectionPage extends StatefulWidget {
  @override
  _NoConnectionPageState createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Отсутствует подключение к интернету'
        ),
      ),
    );
  }
}
