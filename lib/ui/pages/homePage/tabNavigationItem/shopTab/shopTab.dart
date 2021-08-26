import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/shopTab/productPage.dart';
import 'dart:convert';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShopTab extends StatefulWidget {
  @override
  ShopTabState createState() => ShopTabState();
}

class ShopTabState extends State<ShopTab> {
  List<Map<String, dynamic>> tempData = [
    {
      'title': 'Подарочный набор "С бородой"',
      'price': 800,
      'image':
          'https://static.tildacdn.com/tild3166-6266-4165-a131-323063343530/__.jpg',
    },
    {
      'title': 'Пастила Ассорти с ягодами, бананом и яблоком',
      'price': 299,
      'image':
          'https://static.tildacdn.com/tild6639-3236-4637-b966-336131323964/__.jpg',
    },
    {
      'title': 'Подарочный набор "Сердце"',
      'price': 949,
      'image':
          'https://static.tildacdn.com/tild3432-3334-4166-a261-303232376235/80004.jpg',
    },
    {
      'title': 'Подарочный набор "С цветами"',
      'price': 800,
      'image':
          'https://static.tildacdn.com/tild3563-6138-4135-b134-373330303630/__.jpg',
    },
    {
      'title': 'Подарочный набор "Шкатулка"',
      'price': 1004,
      'image':
          'https://static.tildacdn.com/tild6131-6239-4231-b866-623166613533/_.jpg',
    },
    {
      'title': 'Подарочный набор "Скворечник"',
      'price': 761,
      'image':
          'https://static.tildacdn.com/tild3636-3236-4563-a530-353163393238/_.jpg',
    },
    {
      'title': 'Подарочная карта Калина-Малина номинал 1000 р.',
      'price': 1000,
      'image':
          'https://static.tildacdn.com/tild3764-3432-4536-b830-633134313735/_1.jpg',
    },
  ];
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
      return StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(15.0),
        crossAxisCount: 4,
        itemCount: tempData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    title: tempData[index]['title'],
                    price: tempData[index]['price'],
                    image: tempData[index]['image'],
                    tag: 'productImage$index',
                  ),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Hero(
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'graphics/placeholder.png',
                          image: tempData[index]['image'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    tag: 'productImage$index',
                  ),
                  ListTile(
                    title: Text(
                      // snapshot.data[index]['title'],
                      tempData[index]['title'],
                      style: TextStyle(color: LightColor.text),
                    ),
                    subtitle: Text(
                      // '${snapshot.data[index]['price']} бонусов',
                      '${tempData[index]['price']} бонусов',
                      style: TextStyle(color: LightColor.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
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
