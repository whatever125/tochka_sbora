import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tochka_sbora/ui/themes/colors.dart';

class ShopTab extends StatefulWidget {
  @override
  ShopTabState createState() => ShopTabState();
}

class ShopTabState extends State<ShopTab> {
  late Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFeed(),
    );
  }

  Widget _buildFeed() {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
            child: _listView(snapshot),
            onRefresh: _pullRefresh,
            color: LightColor.accent,
          );
        },
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      final list = [
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild3166-6266-4165-a131-323063343530/__.jpg'), width: 60,),
          title: Text(
            'Подарочный набор "С бородой" от Валерия Кокина',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '800 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild6639-3236-4637-b966-336131323964/__.jpg'), width: 60,),
          title: Text(
            'Пастила Ассорти с ягодами, бананом и яблоком в коробке от Натальи Саблиной 55 г',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '299 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild3432-3334-4166-a261-303232376235/80004.jpg'), width: 60,),
          title: Text(
            'Подарочный набор "Сердце" от Дениса Давыдова',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '949 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild3563-6138-4135-b134-373330303630/__.jpg'), width: 60,),
          title: Text(
            'Подарочный набор "С цветами" от Валерия Кокина',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '800 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild6131-6239-4231-b866-623166613533/_.jpg'), width: 60,),
          title: Text(
            'Подарочный набор "Шкатулка" от Ивана Саенко (медовый набор 4 х 150 г)',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '1004 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild3636-3236-4563-a530-353163393238/_.jpg'), width: 60,),
          title: Text(
            'Подарочный набор "Скворечник" от Ивана Саенко (медовый набор 2 х 250 г)',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '761 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
        ListTile(
          leading: Container(child: Image.network('https://static.tildacdn.com/tild3764-3432-4536-b830-633134313735/_1.jpg'), width: 60,),
          title: Text(
            'Подарочная карта Калина-Малина номинал 1000 р.',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '1000 бонусов',
            style: TextStyle(color: LightColor.secondary),
          ),
        ),
      ];
      return ListView.builder(
        shrinkWrap: false,
        padding: EdgeInsets.all(15.0),
        itemCount: list.length * 2,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          final i = index ~/ 2;
          return list[i];
        },
      );
    } else {
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent)));
    }
  }

  Future<void> _pullRefresh() async {
    List<dynamic> freshData = await fetchFeed();
    setState(() {
      data = Future.value(freshData);
    });
  }

  Future<List<dynamic>> fetchFeed() async {
    final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }
}
