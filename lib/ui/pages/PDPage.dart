import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';

class PDPage extends StatefulWidget {
  const PDPage({Key? key}) : super(key: key);

  @override
  _PDPageState createState() => _PDPageState();
}

class _PDPageState extends State<PDPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();

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
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        'Войти',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) => false),
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

  Future<Map<String, dynamic>> _fetchUser() async {
    final APP_TOKEN = 'PX6eUmgv4th7GKqhqDr8E5AZt8SFi2Ja';
    var first_name = firstNameController.text;
    var last_name = lastNameController.text;
    var patronymic = patronymicController.text;
    final apiUrl =
        "http://tochkasbora.pythonanywhere.com/api/try_authentication?app_token=$APP_TOKEN&first_name=$first_name&first_name=$last_name&first_name=$patronymic&format=json";
    var result = await http.get(Uri.parse(apiUrl));
    var res = json.decode(result.body);
    return res;
  }
}
