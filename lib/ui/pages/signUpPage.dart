import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                          text: 'Создайте профиль',
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
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: LightColor.accent,
                ),
                child: Padding(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Имя',
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: LightColor.accent,
                ),
                child: Padding(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: LightColor.accent,
                ),
                child: Padding(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Пароль',
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: LightColor.accent,
                ),
                child: Padding(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Проверка пароля',
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
              Padding(
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF1DA1F2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    child: Text(
                      'Зарегистрироваться',
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
