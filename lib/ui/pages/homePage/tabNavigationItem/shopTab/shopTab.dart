import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/shopTab/productPage.dart';

class ShopTab extends StatefulWidget {
  @override
  ShopTabState createState() => ShopTabState();
}

class ShopTabState extends State<ShopTab> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
    'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _database.child('products/').onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _products = List<dynamic>.from((snapshot.data as Event).snapshot.value);
          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(15.0),
            crossAxisCount: 4,
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        index: index,
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
                              image: _products[index]['image'],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        tag: 'productImage$index',
                      ),
                      ListTile(
                        title: Text(
                          _products[index]['title'],
                          style: TextStyle(color: LightColor.text),
                        ),
                        subtitle: Text(
                          '${_products[index]['price']} бонусов',
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
      },
    );
  }
}
