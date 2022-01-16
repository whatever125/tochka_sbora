import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late StreamSubscription _coinsStream;
  late Map<String, dynamic> _coins;

  @override
  void initState() {
    super.initState();
    _user = _getUser();
    _activateListeners();
    MetricaPlugin.reportEvent('Отсканирован QR пользователя');
    _loadStatistics();
  }

  Future<Map<String, dynamic>> _getUser() async {
    var _userRef = _database.child('users/${widget.QRCodeData}/');
    return await _userRef.once().then((DataSnapshot snapshot) {
      return Map<String, dynamic>.from(snapshot.value);
    });
  }

  void _activateListeners() {
    _coinsStream = _database.child('misc/coins/').onValue.listen((event) {
      setState(() {
        _coins = Map<String, int>.from(event.snapshot.value);
      });
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
    TextEditingController _cardboardController = TextEditingController(
      text: '0',
    );
    TextEditingController _wastepaperController = TextEditingController(
      text: '0',
    );
    TextEditingController _glassController = TextEditingController(
      text: '0',
    );
    TextEditingController _plasticLidsController = TextEditingController(
      text: '0',
    );
    TextEditingController _aluminiumCansController = TextEditingController(
      text: '0',
    );
    TextEditingController _plasticBottlesController = TextEditingController(
      text: '0',
    );
    TextEditingController _plasticMK2Controller = TextEditingController(
      text: '0',
    );
    TextEditingController _plasticMK5Controller = TextEditingController(
      text: '0',
    );
    TextEditingController _plasticBagsController = TextEditingController(
      text: '0',
    );

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
                      SizedBox(height: 5),
                      Text(
                        userSnapshot.data!['phoneNumber'],
                        style: TextStyle(
                          fontSize: 15,
                          color: LightColor.textSecondary,
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
                            '${userSnapshot.data!['cardboard']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _cardboardController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['wastepaper']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _wastepaperController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['glass']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _glassController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['plasticLids']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _plasticLidsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['aluminiumCans']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _aluminiumCansController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['plasticBottles']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _plasticBottlesController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['plasticMK2']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _plasticMK2Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            '${userSnapshot.data!['plasticMK5']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _plasticMK5Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
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
                            'graphics/plasticBags.png',
                            fit: BoxFit.cover,
                            height: 75,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Пакеты',
                            style: TextStyle(
                              color: LightColor.textSecondary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            userSnapshot.data!['plasticBags'] == null
                                ? '0 г'
                                : '${userSnapshot.data!['plasticBags']} г',
                            style: TextStyle(
                              color: LightColor.accent,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            child: TextFormField(
                              enableInteractiveSelection: false,
                              controller: _plasticBagsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: LightColor.text,
                                    width: 1.0,
                                  ),
                                ),
                                labelText: 'Принято',
                                labelStyle: TextStyle(color: LightColor.text),
                                isDense: true,
                              ),
                              cursorColor: LightColor.accent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                        var _oldCoins = userSnapshot.data!['coins'];
                        int _newCoins = 0;
                        var _oldCardboardCount = userSnapshot.data!['cardboard'];
                        var _newCardboardCount = _cardboardController.text == '' ? 0 : int.parse(_cardboardController.text);
                        _newCoins += ((((_newCardboardCount + _oldCardboardCount) / 1000).floor() - (_oldCardboardCount / 1000).floor()) * _coins['cardboard']) as int;
                        var _oldWastepaperCount = userSnapshot.data!['wastepaper'];
                        var _newWastepaperCount = _wastepaperController.text == '' ? 0 : int.parse(_wastepaperController.text);
                        _newCoins += ((((_newWastepaperCount + _oldWastepaperCount) / 1000).floor() - (_oldWastepaperCount / 1000).floor()) * _coins['wastepaper']) as int;
                        var _oldGlassCount = userSnapshot.data!['glass'];
                        var _newGlassCount = _glassController.text == '' ? 0 : int.parse(_glassController.text);
                        _newCoins += ((((_newGlassCount + _oldGlassCount) / 1000).floor() - (_oldGlassCount / 1000).floor()) * _coins['glass']) as int;
                        var _oldPlasticLidsCount = userSnapshot.data!['plasticLids'];
                        var _newPlasticLidsCount = _plasticLidsController.text == '' ? 0 : int.parse(_plasticLidsController.text);
                        _newCoins += ((((_newPlasticLidsCount + _oldPlasticLidsCount) / 1000).floor() - (_oldPlasticLidsCount / 1000).floor()) * _coins['plasticLids']) as int;
                        var _oldAluminiumCansCount = userSnapshot.data!['aluminiumCans'];
                        var _newAluminiumCansCount = _aluminiumCansController.text == '' ? 0 : int.parse(_aluminiumCansController.text);
                        _newCoins += ((((_newAluminiumCansCount + _oldAluminiumCansCount) / 1000).floor() - (_oldAluminiumCansCount / 1000).floor()) * _coins['aluminiumCans']) as int;
                        var _oldPlasticBottlesCount = userSnapshot.data!['plasticBottles'];
                        var _newPlasticBottlesCount = _plasticBottlesController.text == '' ? 0 : int.parse(_plasticBottlesController.text);
                        _newCoins += ((((_newPlasticBottlesCount + _oldPlasticBottlesCount) / 1000).floor() - (_oldPlasticBottlesCount / 1000).floor()) * _coins['plasticBottles']) as int;
                        var _oldPlasticMK2Count = userSnapshot.data!['plasticMK2'];
                        var _newPlasticMK2Count = _plasticMK2Controller.text == '' ? 0 : int.parse(_plasticMK2Controller.text);
                        _newCoins += ((((_newPlasticMK2Count + _oldPlasticMK2Count) / 1000).floor() - (_oldPlasticMK2Count / 1000).floor()) * _coins['plasticMK2']) as int;
                        var _oldPlasticMK5Count = userSnapshot.data!['plasticMK5'];
                        var _newPlasticMK5Count = _plasticMK5Controller.text == '' ? 0 : int.parse(_plasticMK5Controller.text);
                        _newCoins += ((((_newPlasticMK5Count + _oldPlasticMK5Count) / 1000).floor() - (_oldPlasticMK5Count / 1000).floor()) * _coins['plasticMK5']) as int;
                        var _oldPlasticBagsCount = userSnapshot.data!['plasticBags'];
                        var _newPlasticBagsCount = _plasticBagsController.text == '' ? 0 : int.parse(_plasticBagsController.text);
                        _newCoins += ((((_newPlasticBagsCount + _oldPlasticBagsCount) / 1000).floor() - (_oldPlasticBagsCount / 1000).floor()) * _coins['plasticBags']) as int;
                        await _userRef.update({
                          'cardboard': _oldCardboardCount + _newCardboardCount,
                          'wastepaper': _oldWastepaperCount + _newWastepaperCount,
                          'glass': _oldGlassCount + _newGlassCount,
                          'plasticLids': _oldPlasticLidsCount + _newPlasticLidsCount,
                          'aluminiumCans': _oldAluminiumCansCount + _newAluminiumCansCount,
                          'plasticBottles': _oldPlasticBottlesCount + _newPlasticBottlesCount,
                          'plasticMK2': _oldPlasticMK2Count + _newPlasticMK2Count,
                          'plasticMK5': _oldPlasticMK5Count + _newPlasticMK5Count,
                          'plasticBags': _oldPlasticBagsCount + _newPlasticBagsCount,
                          'coins': _oldCoins + _newCoins,
                        });
                        DateTime now = DateTime.now();
                        String date = now.year.toString() + '-' + now.month.toString() + '-' + now.day.toString();
                        Map<String, int> difference = {
                          'cardboard':_newCardboardCount,
                          'wastepaper': _newWastepaperCount,
                          'glass': _newGlassCount,
                          'plasticLids': _newPlasticLidsCount,
                          'aluminiumCans': _newAluminiumCansCount,
                          'plasticBottles': _newPlasticBottlesCount,
                          'plasticMK2': _newPlasticMK2Count,
                          'plasticMK5': _newPlasticMK5Count,
                          'plasticBags': _newPlasticBagsCount,
                        };
                        _addStatistics(date, difference);
                        MetricaPlugin.reportEvent(
                            'Пользователю начислены баллы');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 5),
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

  @override
  deactivate() {
    _coinsStream.cancel();
    super.deactivate();
  }

  void _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('statistics')) {
      prefs.setString('statistics', json.encode(Map()));
    }
  }

  void _addStatistics(String date, Map<String, int> difference) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Map<String, dynamic> statistics = json.decode(prefs.getString('statistics') ?? 'Map()');
      if(!statistics.containsKey(date)) {
        statistics[date] = {
          'cardboard': 0,
          'wastepaper': 0,
          'glass': 0,
          'plasticLids': 0,
          'aluminiumCans': 0,
          'plasticBottles': 0,
          'plasticMK2': 0,
          'plasticMK5': 0,
          'plasticBags': 0,
        };
      }
      statistics[date]['cardboard'] += difference['cardboard'] as int;
      statistics[date]['wastepaper'] += difference['wastepaper'] as int;
      statistics[date]['glass'] += difference['glass'] as int;
      statistics[date]['plasticLids'] += difference['plasticLids'] as int;
      statistics[date]['aluminiumCans'] += difference['aluminiumCans'] as int;
      statistics[date]['plasticBottles'] += difference['plasticBottles'] as int;
      statistics[date]['plasticMK2'] += difference['plasticMK2'] as int;
      statistics[date]['plasticMK5'] += difference['plasticMK5'] as int;
      statistics[date]['plasticBags'] += difference['plasticBags'] as int;
      prefs.setString('statistics', json.encode(statistics));
    });

  }
}
