import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    _uid = _getUID();
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
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
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
}
