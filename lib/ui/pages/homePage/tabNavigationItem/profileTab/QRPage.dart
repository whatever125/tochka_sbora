import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data:
                  "e165grefw8dsgrb2ef56g8rw1v8e9b651e8b51f98wr74b65189e4b1rbv1",
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
      ),
    );
  }
}
