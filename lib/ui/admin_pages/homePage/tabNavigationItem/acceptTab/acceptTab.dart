import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AcceptTab extends StatefulWidget {
  @override
  _AcceptTabState createState() => _AcceptTabState();
}

class _AcceptTabState extends State<AcceptTab> {
  late Future<List<dynamic>> user;

  var cardboardCount = 0;
  var paperCount = 0;
  var glassCount = 0;
  var lidsCount = 0;
  var aluminCount = 0;
  var PETCount = 0;
  var PNDCount = 0;
  var PPCount = 0;

  @override
  void initState() {
    super.initState();
    user = _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Принять мусор', style: TextStyle(color: LightColor.text))),
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
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
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
                        Column(
                          children: [
                            Image.asset(
                              'graphics/cardboard_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Картон',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${cardboardCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  cardboardCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['cardboard'] + cardboardCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (cardboardCount > 0) cardboardCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/paper_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Макулатура',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${paperCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  paperCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['wastepaper'] + paperCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (paperCount > 0) paperCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/glass_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Стекло',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${glassCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  glassCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['glass'] + glassCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (glassCount > 0) glassCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/lid_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Крышки',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${lidsCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  lidsCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['plastic_lid'] + lidsCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (lidsCount > 0) lidsCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
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
                              'graphics/alluminium_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Алюминий',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${aluminCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  aluminCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['aluminium_can'] + aluminCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (aluminCount > 0) aluminCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/PET_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Бутылки ПЭТ',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${PETCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  PETCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['plastic_bottle'] + PETCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (PETCount > 0) PETCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/2_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ПНД',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${PNDCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  PNDCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['plastic_mk2'] + PNDCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (PNDCount > 0) PNDCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'graphics/5_1.png',
                              fit: BoxFit.cover,
                              height: 75,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ПП',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '+${PPCount * 50} г',
                              style: TextStyle(
                                color: LightColor.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  PPCount += 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: LightColor.accent,
                              ),
                            ),
                            Text(
                              '${(snapshot.data[0]['plastic_mk5'] + PPCount) * 50} г',
                              style: TextStyle(
                                color: LightColor.text,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: () => {
                                setState(() {
                                  if (PPCount > 0) PPCount -= 1;
                                })
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: LightColor.accent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: LightColor.accent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    child: Text(
                      'Принять',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                  ),
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
}
