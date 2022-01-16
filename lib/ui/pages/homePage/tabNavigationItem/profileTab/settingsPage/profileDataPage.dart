import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class ProfileDataPage extends StatefulWidget {
  @override
  _ProfileDataPageState createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {
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
        title: Text('Личные данные', style: TextStyle(color: LightColor.text)),
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
                enableInteractiveSelection: false,
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
                enableInteractiveSelection: false,
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
                enableInteractiveSelection: false,
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
                '*Телефон',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                enableInteractiveSelection: false,
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
