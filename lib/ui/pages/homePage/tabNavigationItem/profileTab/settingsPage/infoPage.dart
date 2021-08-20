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
        child: Text(
          'Версия 1.0.0\n\nСделано с любовью в России, г. Кемерово.\nПриложение создано для помощи нашему городу и вознаграждения заинтересованных в этом людей.',
          style: TextStyle(
            color: LightColor.text,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
