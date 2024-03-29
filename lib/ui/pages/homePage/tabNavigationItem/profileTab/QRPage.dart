import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock/wakelock.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final _auth = FirebaseAuth.instance;
  late var _uid;

  @override
  void initState() {
    super.initState();
    _setBrightnessAndWake(1);
    _uid = _getUID();
  }

  Future<void> _setBrightnessAndWake(double brightness) async {
    Wakelock.enable();
    await ScreenBrightness.setScreenBrightness(brightness);
  }

  _getUID() async {
    final _user = _auth.currentUser;
    return _user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: _buildQR(),
    );
  }

  Widget _buildQR() {
    return Container(
      child: FutureBuilder(
        future: _uid,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: "${snapshot.data}",
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    'Покажите этот QR код сотруднику "Точки сбора" для идентификации вашей личности',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _resetBrightnessAndWake();
  }

  Future<void> _resetBrightnessAndWake() async {
    Wakelock.disable();
    await ScreenBrightness.resetScreenBrightness();
  }
}
