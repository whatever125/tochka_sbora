import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class AcceptTab extends StatefulWidget {
  late final String QRCodeData;
  AcceptTab(this.QRCodeData);

  @override
  _AcceptTabState createState() => _AcceptTabState();
}

class _AcceptTabState extends State<AcceptTab> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  late Future<Map<String, dynamic>> _user;

  var _cardboardCount = 0;
  var _wastepaperCount = 0;
  var _glassCount = 0;
  var _plasticLidsCount = 0;
  var _aluminiumCansCount = 0;
  var _plasticBottlesCount = 0;
  var _plasticMK2Count = 0;
  var _plasticMK5Count = 0;

  @override
  void initState() {
    super.initState();
    _user = _getUser();
  }

  Future<Map<String, dynamic>> _getUser() async {
    var _userRef = _database.child('users/${widget.QRCodeData}/');
    return await _userRef.once().then((DataSnapshot snapshot) {
      return Map<String, dynamic>.from(snapshot.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Принять мусор',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return Container(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _user,
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
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
                                  "${userSnapshot.data!['surname']} ${userSnapshot.data!['name']} ${userSnapshot.data!['secondName']}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                            '${userSnapshot.data!['coins']}',
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
                                'graphics/cardboard.png',
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
                                '+${_cardboardCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _cardboardCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['cardboard'] + _cardboardCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_cardboardCount > 0)
                                      _cardboardCount -= 1;
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
                                'graphics/wastepaper.png',
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
                                '+${_wastepaperCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _wastepaperCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['wastepaper'] + _wastepaperCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_wastepaperCount > 0)
                                      _wastepaperCount -= 1;
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
                                'graphics/glass.png',
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
                                '+${_glassCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _glassCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['glass'] + _glassCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_glassCount > 0) _glassCount -= 1;
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
                                'graphics/plasticLids.png',
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
                                '+${_plasticLidsCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _plasticLidsCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['plasticLids'] + _plasticLidsCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_plasticLidsCount > 0)
                                      _plasticLidsCount -= 1;
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
                                'graphics/aluminiumCans.png',
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
                                '+${_aluminiumCansCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _aluminiumCansCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['aluminiumCans'] + _aluminiumCansCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_aluminiumCansCount > 0)
                                      _aluminiumCansCount -= 1;
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
                                'graphics/plasticBottles.png',
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
                                '+${_plasticBottlesCount * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _plasticBottlesCount += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['plasticBottles'] + _plasticBottlesCount) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_plasticBottlesCount > 0)
                                      _plasticBottlesCount -= 1;
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
                                'graphics/plasticMK2.png',
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
                                '+${_plasticMK2Count * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _plasticMK2Count += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['plasticMK2'] + _plasticMK2Count) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_plasticMK2Count > 0)
                                      _plasticMK2Count -= 1;
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
                                'graphics/plasticMK5.png',
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
                                '+${_plasticMK5Count * 50} г',
                                style: TextStyle(
                                  color: LightColor.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    _plasticMK5Count += 1;
                                  })
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: LightColor.accent,
                                ),
                              ),
                              Text(
                                '${(userSnapshot.data!['plasticMK5'] + _plasticMK5Count) * 50} г',
                                style: TextStyle(
                                  color: LightColor.accent,
                                  fontSize: 20,
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  setState(() {
                                    if (_plasticMK5Count > 0)
                                      _plasticMK5Count -= 1;
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
                      onPressed: () async {
                        var _userRef =
                            _database.child('users/${widget.QRCodeData}/');
                        await _userRef.update({
                          'cardboard':
                              userSnapshot.data!['cardboard'] + _cardboardCount,
                          'wastepaper': userSnapshot.data!['wastepaper'] +
                              _wastepaperCount,
                          'glass': userSnapshot.data!['glass'] + _glassCount,
                          'plasticLids': userSnapshot.data!['plasticLids'] +
                              _plasticLidsCount,
                          'aluminiumCans': userSnapshot.data!['aluminiumCans'] +
                              _aluminiumCansCount,
                          'plasticBottles':
                              userSnapshot.data!['plasticBottles'] +
                                  _plasticBottlesCount,
                          'plasticMK2': userSnapshot.data!['plasticMK2'] +
                              _plasticMK2Count,
                          'plasticMK5': userSnapshot.data!['plasticMK5'] +
                              _plasticMK5Count,
                          'coins': userSnapshot.data!['coins'] +
                              _cardboardCount +
                              _wastepaperCount +
                              _glassCount +
                              _plasticLidsCount +
                              _aluminiumCansCount +
                              _plasticBottlesCount +
                              _plasticMK2Count +
                              _plasticMK5Count,
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
              ),
            );
          }
        },
      ),
    );
  }
}
