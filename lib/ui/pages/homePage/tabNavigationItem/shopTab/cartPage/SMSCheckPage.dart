import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mailer/smtp_server.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:mailer/mailer.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';

class SMSCheckPage extends StatefulWidget {
  @override
  _SMSCheckPageState createState() => _SMSCheckPageState();
}

class _SMSCheckPageState extends State<SMSCheckPage> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  final _auth = FirebaseAuth.instance;

  final _smsController = TextEditingController();
  final _autoFill = SmsAutoFill();

  late StreamSubscription _emailDataStream;
  String _fromEmail = '';
  String _fromPassword = '';
  String _fromName = '';
  String _fromSubject = '';
  String _toEmail = '';

  @override
  void initState() {
    super.initState();
    _listenForCode();
    _activateListeners();
  }

  void _listenForCode() async {
    await SmsAutoFill().listenForCode;
  }

  void _activateListeners() {
    _emailDataStream = _database.child('misc/email/').onValue.listen((event) {
      var _data = event.snapshot.value;
      setState(() {
        _fromEmail = _data['fromEmail'];
        _fromPassword = _data['fromPassword'];
        _fromName = _data['fromName'];
        _fromSubject = _data['fromSubject'];
        _toEmail = _data['toEmail'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Подтверждение заказа',
          style: TextStyle(color: LightColor.text),
        ),
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
                  height: 30,
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
                    'Готово',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    if (await _signInWithPhoneNumber(context)) {
                      var _userRef =
                          _database.child('users/${_auth.currentUser!.uid}/');
                      if (await _sendEmail()) {
                        await _userRef.once().then((userSnapshot) async {
                          var _productsRef = _database.child('products/');
                          await _productsRef.once().then((productsSnapshot) async {
                            var _productsRefData = productsSnapshot.value;
                            var _userRefData = userSnapshot.value;
                            num _summ = 0;
                            var _cart = Map<String, dynamic>.from(_userRefData['cart']);
                            for (int i = 0; i < _cart.length; i++) {
                              int _productIndex = int.parse(_cart.keys.elementAt(i)[8]);
                              _summ = _summ +
                                  _cart[_cart.keys.elementAt(i)] *
                                      _productsRefData[_productIndex]['price'];
                            }
                            await _userRef.update({'coins': _userRefData['coins'] -  _summ});
                          });
                        });
                        await _userRef.update({'cart': null});
                        await MetricaPlugin.reportEvent('Пользователь сделал заказ');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    }
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

  Future<bool> _signInWithPhoneNumber(context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: await StorageManager.readData('verificationId'),
        smsCode: _smsController.text,
      );
      var _uid = (await _auth.signInWithCredential(credential)).user!.uid;
      return true;
    } catch (e) {
      var _error = e.toString();
      if (_error.contains('invalid-verification-code') | _error.contains('invalid-verification-id'))
        _showSnackbar("Неверный SMS код");
      else
        _showSnackbar("SMS Ошибка: " + _error);
      return false;
    }
  }

  void _showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> _sendEmail() async {
    try {
      late var _userData;
      late var _products;
      await _database
          .child('users/${_auth.currentUser!.uid}/')
          .once()
          .then((value) {
        _userData = value.value;
      });
      await _database.child('products/').once().then((value) {
        _products = value.value;
      });
      var _cart = _userData['cart'] == null
          ? <String, dynamic>{}
          : Map<String, dynamic>.from(_userData['cart']);
      var _productsTable = '';
      for (int i = 0; i < _cart.length; i++) {
        int _productIndex = int.parse(_cart.keys.elementAt(i)[8]);
        _productsTable +=
            '''<tr><td>${_products[_productIndex]["title"]}</td><td>${_cart[_cart.keys.elementAt(i)]}</td></tr>''';
      }
      final _smtpServer = hotmail(_fromEmail, _fromPassword);
      final _message = Message()
        ..from = Address(_fromEmail, _fromName)
        ..recipients = [_toEmail]
        ..subject = _fromSubject
        ..html = '''\
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <style>
      .rozovy {
        background-color: #e11344;
      }
      .bely {
        background-color: #FAFAFA;
      }
    </style>
  </head>
  <body class="bely">
    <div class="text-center " style="width: 600px">
      <div class="p-4 p-md-5 mb-4 text-white rozovy">
        <h1>Информация о заказе</h1>
      </div>
      <h4>${_userData["surname"]} ${_userData["name"]} ${_userData["secondName"]}</h4>
      <h6 class="text-muded">тел. ${_userData["phoneNumber"]}</h6>
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">Товар</th>
            <th scope="col">Количество</th>
          </tr>
        </thead>
        <tbody>
          ''' + _productsTable + '''</tbody></table></div></body></html>''';
      await send(_message, _smtpServer);

      return true;
    } catch (e) {
      _showSnackbar("Ошибка: " + e.toString());
      return false;
    }
  }

  @override deactivate() {
    _emailDataStream.cancel();
    super.deactivate();
  }
}
