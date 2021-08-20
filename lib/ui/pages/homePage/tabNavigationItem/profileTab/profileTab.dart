import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/personalDataPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tochka_sbora/ui/themes/theme.dart';

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

//TODO QR
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
                                          "${snapshot.data[0]['lastName']} ${snapshot.data[0]['firstName']} ${snapshot.data[0]['middleName']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                snapshot.data[0]['phone'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: LightColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                          'Монеты: ',
                          style: TextStyle(
                            color: LightColor.text,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                            color: LightColor.accent,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'graphics/cardboard.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Картон',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/paper.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Макулатура',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/glass.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Стекло',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/lid.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Крышки',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'graphics/alluminium.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Алюминий',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/PET.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Бутылки ПЭТ',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/2.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ПНД',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/5.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ПП',
                              style: TextStyle(
                                color: LightColor.secondary,
                              ),
                            ),
                          ],
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
                          color: AppTheme.lightTheme.accentColor,
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
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent)));
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
}
