import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/signinPage.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';

class DayStatisticsPage extends StatefulWidget {
  final String date;
  DayStatisticsPage({
    required this.date,
  });
  @override
  _DayStatisticsPageState createState() => _DayStatisticsPageState();
}

class _DayStatisticsPageState extends State<DayStatisticsPage> {
  late String _selectedDay;
  late var statistics;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.date;
    _loadStatistics();
    statistics = _getStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: statistics,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> _statistics = snapshot.data as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Статистика за ${_selectedDay}',
                style: TextStyle(color: LightColor.text),
              ),
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: [
                    Row(children: [
                      Text(
                        'Картон',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Spacer(),
                      Text(_statistics['cardboard'] == null ? '0' : _statistics['cardboard'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Макулатура', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['wastepaper'] == null ? '0' : _statistics['wastepaper'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Стекло', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['glass'] == null ? '0' : _statistics['glass'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Крышки', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['plasticLids'] == null ? '0' : _statistics['plasticLids'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Алюминий', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['aluminiumCans'] == null ? '0' : _statistics['aluminiumCans'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Бутылки ПЭТ', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['plasticBottles'] == null ? '0' : _statistics['plasticBottles'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('ПНД', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['plasticMK2'] == null ? '0' : _statistics['plasticMK2'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('ПП', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['plasticMK5'] == null ? '0' : _statistics['plasticMK5'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ]),
                    Row(children: [
                      Text('Пакеты', style: TextStyle(fontSize: 25.0)),
                      Spacer(),
                      Text(_statistics['plasticBags'] == null ? '0' : _statistics['plasticBags'].toString(),
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 30.0))
                    ])
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
              ),
            ),
          );
        }
      },
    );
  }

  void _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('statistics')) {
      prefs.setString('statistics', json.encode(Map()));
    }
  }

  _getStatistics() async {
    var data = await StorageManager.readData('statistics');
    Map<String, dynamic> statistics = json.decode(data);
    if(!statistics.containsKey(_selectedDay)) {
      statistics[_selectedDay] = {
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
    return statistics[_selectedDay];
  }
}
