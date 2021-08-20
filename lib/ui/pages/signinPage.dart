import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: FlutterLogo(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                              )),
                        ],
                      ),
                    )),
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                ),
              ),
              Padding(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    return true
                        ? null
                        : 'Пожалуйста, введите корректный номер телефона';
                  },
                  inputFormatters: [
                    PhoneInputFormatter(),
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Номер телефона',
                    //TODO цвет ввода
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              Padding(
                child: Container(
                  height: 50,
                  width: 125,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.accentColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton(
                    child: Text(
                      'Войти',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => route.isFirst,
                      ),
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
      ),
    );
  }
}
