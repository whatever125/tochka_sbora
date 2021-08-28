import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/settingsPage/settingsPage.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/QRPage.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Future<List<dynamic>> user;

  @override
  void initState() {
    super.initState();
    user = _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
            child: _profileView(snapshot),
            onRefresh: _pullRefresh,
            color: LightColor.accent,
          );
        },
      ),
    );
  }

  Widget _profileView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          "Иванов Иван Иванович",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '+7 (912) 345-67-89',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: LightColor.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QRPage()),
                          ),
                        },
                        child: Icon(
                          Icons.qr_code,
                          color: LightColor.accent,
                          size: 40,
                        ),
                      )
                    ],
                  ),
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
                          '${snapshot.data[0]['coins']}',
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
                          amount: snapshot.data[0]['cardboard'],
                        ),
                        _generateTile(
                          name: 'wastepaper',
                          title: 'Макулатура',
                          amount: snapshot.data[0]['wastepaper'],
                        ),
                        _generateTile(
                          name: 'glass',
                          title: 'Стекло',
                          amount: snapshot.data[0]['glass'],
                        ),
                        _generateTile(
                          name: 'plasticLids',
                          title: 'Крышки',
                          amount: snapshot.data[0]['plasticLids'],
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
                          amount: snapshot.data[0]['aluminiumCans'],
                        ),
                        _generateTile(
                          name: 'plasticBottles',
                          title: 'Бутылки ПЭТ',
                          amount: snapshot.data[0]['plasticBottles'],
                        ),
                        _generateTile(
                          name: 'plasticMK2',
                          title: 'ПНД',
                          amount: snapshot.data[0]['plasticMK2'],
                        ),
                        _generateTile(
                          name: 'plasticMK5',
                          title: 'ПП',
                          amount: snapshot.data[0]['plasticMK5'],
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
                              .copyWith(fontSize: 18, color: LightColor.text),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
        ),
      );
    }
  }

  Future<void> _pullRefresh() async {
    List<dynamic> freshData = await _fetchProfile();
    setState(() {
      user = Future.value(freshData);
    });
  }

  Future<List<dynamic>> _fetchProfile() async {
    final apiUrl = "https://60911f0c50c2550017677a1b.mockapi.io/users";
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  _generateTile({required name, required title, required amount}) {
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
          '${amount * 50} г',
          style: TextStyle(
            color: LightColor.accent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
