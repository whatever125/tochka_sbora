import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
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
        title: Text('Личные данные'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '*Фамилия',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  return val!.isEmpty ? 'Пожалуйста, укажите фамилию' : null;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '*Имя',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  return val!.isEmpty ? 'Пожалуйста, укажите имя' : null;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Отчество',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                validator: (val) {
                  return val!.isEmpty ? 'Пожалуйста, укажите отчество' : null;
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '*Дата рождения',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _dobctrl,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await _selectDate(context);
                  _dobctrl.text = _dateOfBirth == null
                      ? ''
                      : DateFormat('dd.MM.yyyy').format(_dateOfBirth);
                },
                readOnly: true,
                autovalidateMode: AutovalidateMode.disabled,
                validator: (val) {
                  return val!.isEmpty
                      ? 'Пожалуйста, укажите дату рождения'
                      : null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                // DateFormat('dd-MM-yyyy').format(_dateOfBirth),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '*Телефон',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
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
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '*Email',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) => EmailValidator.validate(val!)
                    ? null
                    : "Пожалуйста, укажите корректный email",
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: TextButton(
                      child: Text(
                        'Сохранить',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => {
                        Navigator.of(context).pop(),
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
