import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/acceptTab/acceptTab.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
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
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: LightColor.accent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    child: Text(
                      'Сканировать QR',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () => {
                      controller.resumeCamera()
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.pauseCamera();
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      var data = scanData.code;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AcceptTab(data)),
      );
    });
  }
}
