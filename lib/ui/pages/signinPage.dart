import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/ui/pages/SMSPage.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();

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
                        text: 'Добро пожаловать',
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
              child: TextFormField(
                controller: _phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  return val!.isEmpty
                      ? 'Пожалуйста, введите номер телефона'
                      : null;
                },
                inputFormatters: [
                  PhoneInputFormatter(),
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: LightColor.text, width: 1.0)),
                    labelText: 'Номер телефона',
                    labelStyle: TextStyle(color: LightColor.text)),
                cursorColor: LightColor.accent,
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
                    if (await _verifyPhoneNumber()) {
                      await MetricaPlugin.reportEvent(
                          "Пользователь ввел номер телефона");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SMSPage(),
                        ),
                      );
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

  Future<bool> _verifyPhoneNumber() async {
    if (_phoneNumberController.text == '') return false;
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      _showSnackbar('Автоматический вход: ${_auth.currentUser!.uid}');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      var _error = authException.code;
      if (_error == 'invalid-phone-number')
        _showSnackbar("Неправильно набран номер");
      else
        _showSnackbar(
            'Код ошибки: ${authException.code}. Сообщение: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _showSnackbar(
          'На ваш номер телефона отправлено СМС с шестизначным кодом');
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      StorageManager.saveData('verificationId', verificationId);
    };

    _auth.setLanguageCode("ru");
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      timeout: const Duration(seconds: 0),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
    StorageManager.saveData('phoneNumber', _phoneNumberController.text);
    return true;
  }

  void _showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
