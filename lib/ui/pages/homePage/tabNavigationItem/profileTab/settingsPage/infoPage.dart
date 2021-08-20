import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late DateTime _dateOfBirth;
  TextEditingController _dobctrl = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth == null ? DateTime.now() : _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ru', 'RU'),
    );
    if (picked != null && picked != _dateOfBirth)
      setState(() {
        _dateOfBirth = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('О приложении', style: TextStyle(color: LightColor.text)),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text('Версия 1.0.0\n\nСделано с любовью в России, г. Кемерово.\nПриложение создано для помощи нашему городу и вознаграждения заинтересованных в этом людей.',
      style: TextStyle(color: LightColor.text, fontSize: 20, ),
      ),
    ));
  }
}