import 'package:flutter/cupertino.dart';
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
          leading: Image.network('https://static.tildacdn.com/tild3166-6266-4165-a131-323063343530/__.jpg'),
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
          leading: Image.network('https://static.tildacdn.com/tild6639-3236-4637-b966-336131323964/__.jpg'),
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
          leading: Image.network('https://static.tildacdn.com/tild3432-3334-4166-a261-303232376235/80004.jpg'),
          title: Text(
            'Подарочный набор "Сердце" от Дениса Давыдова',
            style: TextStyle(color: LightColor.text),
          ),
          subtitle: Text(
            '949 бонусов',
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
