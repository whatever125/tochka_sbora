import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/signinPage.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    MetricaPlugin.reportEvent("WelcomePage", attributes: {"attribute_1": "value_1", "attribute_2": "value_2"});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).backgroundColor,
      statusBarIconBrightness: Brightness.dark
    ));
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'graphics/name.png',
                height: 32,
              ),
              Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    color: LightColor.text,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Начни помогать планете!', //TODO
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.accentColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  child: Text(
                    'Начать',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    await MetricaPlugin.reportEvent('Пользователь нажал кнопку "Начать"');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'graphics/kalina.png',
                    height: 100,
                  ),
                  Image.asset(
                    'graphics/volkov.png',
                    height: 100,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
