import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/acceptTab/acceptTab.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void initState() {
    super.initState();
    MetricaPlugin.reportEvent('Пользователь открыл QR сканер');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: LightColor.accent,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.pauseCamera();
    controller.scannedDataStream.listen(
      (scanData) async {
        var data = scanData.code;
        print(data);
        _database.child('users/$data').once().then(
          (DataSnapshot snapshot) {
            if (snapshot.exists) {
              controller.pauseCamera();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcceptTab(data)),
              ).then(
                (value) => controller.resumeCamera(),
              );
            }
          },
        );
      },
    );
  }
}
