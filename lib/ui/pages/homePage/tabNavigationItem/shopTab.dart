import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "dart:math";

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
          );
        },
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      final _random = new Random();
      final list = [
        ListTile(
          leading: Icon(
            Icons.people,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            'Приглашение на собеседование',
          ),
          subtitle: Text(
            'На должность экономист от КУ "Региональный центр для лиц без определенного места жительства" Минтруда Кузбасса 21.06.2021 10:30',
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.cancel,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            'Статус обращения',
          ),
          subtitle: Text(
            'Ваше электронное обращение для психологической поддержки от 17.04.2021 отклонено ведомством',
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.check_circle,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            'Статус обращения',
          ),
          subtitle: Text(
            'Ваше электронное обращение для поиска работы от 17.04.2021 рассмотрено. Результат: выполнено',
          ),
        ),
      ];
      return ListView.builder(
        shrinkWrap: false,
        padding: EdgeInsets.all(15.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();
          final i = index ~/ 2;
          return list[_random.nextInt(list.length)];
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
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
