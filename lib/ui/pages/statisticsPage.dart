import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:metrica_plugin/metrica_plugin.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tochka_sbora/ui/pages/dayStatisticsPage.dart';
import 'dart:convert';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/signinPage.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  void initState() {
    MetricaPlugin.reportEvent("StatisticsPage");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children:[Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            sixWeekMonthsEnforced: true,
          )
        ), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => DayStatisticsPage(date: getDate()),
        )), child: Text('Статистика за выбранный день'),)
      ],
      ),
    )
    );
  }

  String getDate() {
    if(_selectedDay == null) return _focusedDay.year.toString() + '-' + _focusedDay.month.toString() + '-' + _focusedDay.day.toString();
    else return _selectedDay!.year.toString() + '-' + _selectedDay!.month.toString() + '-' + _selectedDay!.day.toString();
  }
}