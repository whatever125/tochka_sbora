import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class ProductPage extends StatefulWidget {
  final int index;

  ProductPage({
    required this.index,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Купить товар', style: TextStyle(color: LightColor.text)),
      ),
      body: StreamBuilder(
        stream: _database.child('products/${widget.index}/').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _product = Map.from((snapshot.data as Event).snapshot.value);
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Hero(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'graphics/placeholder.png',
                                  image: _product['image'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          tag: 'productImage${widget.index}',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _product['title'],
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: LightColor.text),
                        ),
                        Text(
                          _product['available'] ? 'В наличии' : 'Отсутствует',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: LightColor.textSecondary),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _product['description'],
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: LightColor.textSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                label: Text(
                  'В корзину за ${_product['price']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (_product['available']) {
                    var _cartRef =
                    _database.child('users/${_auth.currentUser!.uid}/cart/');
                    var _productRef = _cartRef.child('product_${widget.index}/');
                    var num = await (await _productRef.once()).value;
                    num = num == null ? 0 : num;
                    await _cartRef.update({'product_${widget.index}': num + 1});
                  }
                  Navigator.of(context).pop();
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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
