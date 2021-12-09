import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('О приложении', style: TextStyle(color: LightColor.text)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          color: LightColor.text,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Точка сбора',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'graphics/logo.png',
                      fit: BoxFit.cover,
                      height: 75,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Версия 1.1.12',
                      style: TextStyle(
                        color: LightColor.text,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Сдавайте мусор на переработку и получайте бонусы на покупки в «Калина-Малина»!',
              style: TextStyle(
                color: LightColor.text,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
