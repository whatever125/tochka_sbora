import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/settingsPage/settingsPage.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/QRPage.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  final _auth = FirebaseAuth.instance;
  late var _uid;

  @override
  void initState() {
    super.initState();
    _uid = _getUID();
    MetricaPlugin.reportEvent('Пользователь открыл профиль');
  }

  _getUID() async {
    final _user = _auth.currentUser;
    return _user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _uid,
      builder: (context, futureSnapshot) {
        if (futureSnapshot.hasData) {
          return StreamBuilder(
            stream: _database.child('users/${futureSnapshot.data}/').onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _user = Map<String, dynamic>.from(
                    (snapshot.data as Event).snapshot.value);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: LightColor.text,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "${_user['surname']} ${_user['name']} ${_user['secondName']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _user['phoneNumber'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: LightColor.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QRPage()),
                                );
                              },
                              child: Icon(
                                Icons.qr_code_2,
                                color: LightColor.accent,
                                size: 50,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Бонусы: ',
                                  style: TextStyle(
                                    color: LightColor.text,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${_user['coins']}',
                                  style: TextStyle(
                                    color: LightColor.accent,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _generateTile(
                                  name: 'cardboard',
                                  title: 'Картон',
                                  amount: _user['cardboard'],
                                ),
                                _generateTile(
                                  name: 'wastepaper',
                                  title: 'Макулатура',
                                  amount: _user['wastepaper'],
                                ),
                                _generateTile(
                                  name: 'glass',
                                  title: 'Стекло',
                                  amount: _user['glass'],
                                ),
                                _generateTile(
                                  name: 'plasticLids',
                                  title: 'Крышки',
                                  amount: _user['plasticLids'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _generateTile(
                                  name: 'aluminiumCans',
                                  title: 'Алюминий',
                                  amount: _user['aluminiumCans'],
                                ),
                                _generateTile(
                                  name: 'plasticBottles',
                                  title: 'Бутылки ПЭТ',
                                  amount: _user['plasticBottles'],
                                ),
                                _generateTile(
                                  name: 'plasticMK2',
                                  title: 'ПНД',
                                  amount: _user['plasticMK2'],
                                ),
                                _generateTile(
                                  name: 'plasticMK5',
                                  title: 'ПП',
                                  amount: _user['plasticMK5'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _generateTile(
                                  name: 'plasticMK6',
                                  title: 'ПС',
                                  amount: _user['plasticMK6'],
                                ),
                                _generateTile(
                                  name: 'plasticBags',
                                  title: 'Пакеты',
                                  amount: _user['plasticBags'],
                                ),
                                _generateTile(
                                  name: 'steel',
                                  title: 'Жесть',
                                  amount: _user['steel'],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          child: Container(
                            height: 40,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: LightColor.accent,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Настройки',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 18, color: LightColor.text),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            ),
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold();
              }
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
            ),
          );
        }
      },
    );
  }

  Column _generateTile({required name, required title, required amount}) {
    return Column(
      children: [
        Image.asset(
          'graphics/$name.png',
          fit: BoxFit.cover,
          height: 75,
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: LightColor.textSecondary,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '${amount == null ? 0 : amount} г',
          style: TextStyle(
            color: LightColor.accent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
