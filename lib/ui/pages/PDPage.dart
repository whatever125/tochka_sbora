import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/helper/models/userModel.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';

final _database = FirebaseDatabase(
  app: Firebase.apps.first,
  databaseURL:
      'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
).reference();
final _auth = FirebaseAuth.instance;

class PDPage extends StatefulWidget {
  const PDPage({Key? key}) : super(key: key);

  @override
  _PDPageState createState() => _PDPageState();
}

class _PDPageState extends State<PDPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();

  String _url = 'https://kalina-malina.store/';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _database.child('misc/politics/').onValue.listen((event) {
      setState(() {
        _url = event.snapshot.value;
      });
    });
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
        padding: EdgeInsets.all(30),
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
                            text: 'Как вас зовут?',
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
            TextFormField(
              controller: lastNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                return val!.isEmpty ? 'Пожалуйста, укажите фамилию' : null;
              },
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: LightColor.text, width: 1.0)
                ),
                labelText: '*Фамилия',
                labelStyle: TextStyle(color: LightColor.text),
                isDense: true
              ),
              cursorColor: LightColor.accent,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: firstNameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                return val!.isEmpty ? 'Пожалуйста, укажите имя' : null;
              },
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: LightColor.text, width: 1.0)
                  ),
                  labelText: '*Имя',
                  labelStyle: TextStyle(color: LightColor.text),
                  isDense: true
              ),
              cursorColor: LightColor.accent,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: patronymicController,
              autovalidateMode: AutovalidateMode.disabled,
              validator: (val) {
                return val!.isEmpty ? 'Пожалуйста, укажите отчество' : null;
              },
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: LightColor.text, width: 1.0)
                  ),
                  labelText: 'Отчество',
                  labelStyle: TextStyle(color: LightColor.text),
                  isDense: true
              ),
              cursorColor: LightColor.accent,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 250,
                  child: TextButton(
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      if (await _fetchUser())
                        await MetricaPlugin.reportEvent("Пользователь ввел персональные данные");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Text('Регистрируясь, вы соглашаетесь с'),
                  TextButton(
                    onPressed: _launchURL,
                    child: Text('Политикой обработки персональных данных'),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(LightColor.accent),
                      overlayColor:
                          MaterialStateProperty.all<Color>(LightColor.light),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _fetchUser() async {
    var _firstName = firstNameController.text.trim();
    var _lastName = lastNameController.text.trim();
    var _patronymic = patronymicController.text.trim();
    var _phoneNumber = await StorageManager.readData('phoneNumber');
    var _user = UserModel(
      phoneNumber: _phoneNumber,
      name: _firstName,
      secondName: _patronymic,
      surname: _lastName,
    );
    await StorageManager.removeData('phoneNumber');
    final _userRef = _database.child('users/${_auth.currentUser!.uid}/');
    await _userRef.update(_user.toJson());
    return true;
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
