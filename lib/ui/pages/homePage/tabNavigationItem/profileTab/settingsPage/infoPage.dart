import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

final _database = FirebaseDatabase(
  app: Firebase.apps.first,
  databaseURL:
  'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
).reference();

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late StreamSubscription _infoTextStream;
  String _infoText = '';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _infoTextStream = _database.child('misc/infoText/').onValue.listen((event) {
      setState(() {
        _infoText = event.snapshot.value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('О приложении', style: TextStyle(color: LightColor.text)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          color: LightColor.text,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Точка сбора',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'graphics/logo.png',
                      fit: BoxFit.cover,
                      height: 75,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Версия 1.1.12',
                      style: TextStyle(
                        color: LightColor.text,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              _infoText,
              style: TextStyle(
                color: LightColor.text,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override deactivate() {
    _infoTextStream.cancel();
    super.deactivate();
  }
}
