import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SMSPage extends StatefulWidget {
  @override
  _SMSPageState createState() => _SMSPageState();
}

class _SMSPageState extends State<SMSPage> {
  _logInSP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('logged_in', true);
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
                              text: 'Введите код из СМС',
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
                        : 'Пожалуйста, введите корректный код';
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Код',
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
                  width: 175,
                  decoration: BoxDecoration(
                      color: AppTheme.lightTheme.accentColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton(
                    child: Text(
                      'Продолжить',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => {
                      _logInSP(),
                      Navigator.pop(context,),
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (Route<dynamic> route) => false
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
