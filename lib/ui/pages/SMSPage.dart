import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/ui/pages/PDPage.dart';

class SMSPage extends StatefulWidget {
  @override
  _SMSPageState createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  final _auth = FirebaseAuth.instance;

  final _smsController = TextEditingController();
  final _autoFill = SmsAutoFill();

  @override
  void initState() {
    super.initState();
    _listenForCode();
  }

  void _listenForCode() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Image.asset(
          'graphics/name.png',
          height: 32,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 25,
                      color: LightColor.text,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Введите код из СМС',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
            ),
            Padding(
              child: PinFieldAutoFill(
                controller: _smsController,
                cursor: Cursor(
                  color: LightColor.accent,
                  width: 2,
                  height: 40,
                  radius: Radius.circular(1),
                  enabled: true,
                ),
                decoration: BoxLooseDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  strokeColorBuilder: FixedColorBuilder(
                    LightColor.text,
                  ),
                ),
                onCodeChanged: (code) {},
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
            Padding(
              child: Container(
                height: 50,
                width: 175,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.accentColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  child: Text(
                    'Продолжить',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    _signInWithPhoneNumber(context);
                  },
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signInWithPhoneNumber(context) async {
    // try {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: await StorageManager.readData('verificationId'),
      smsCode: _smsController.text,
    );
    var _uid = (await _auth.signInWithCredential(credential)).user!.uid;
    final _userRef = _database.child('users/$_uid/');
    await _userRef.once().then((snapshot) async {
      var userData = snapshot.value;
      if (userData == null) {
        _autoFill.unregisterListener();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PDPage()),
        );
      } else {
        _autoFill.unregisterListener();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
    // } catch (e) {
    //   _showSnackbar("SMS Ошибка: " + e.toString());
    //   return false;
    // }
  }

  void _showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
