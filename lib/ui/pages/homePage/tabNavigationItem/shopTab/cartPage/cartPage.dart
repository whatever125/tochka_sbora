import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'checkOutPage.dart';

final _database = FirebaseDatabase(
  app: Firebase.apps.first,
  databaseURL:
      'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
).reference();
final _auth = FirebaseAuth.instance;

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Корзина',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: StreamBuilder(
        stream: _database.child('products/').onValue,
        builder: (context, productsSnapshot) {
          if (productsSnapshot.hasData) {
            var _products = List<dynamic>.from(
                (productsSnapshot.data as Event).snapshot.value);
            return StreamBuilder(
              stream:
                  _database.child('users/${_auth.currentUser!.uid}/').onValue,
              builder: (context, cartSnapshot) {
                if (cartSnapshot.hasData) {
                  var _cartSnapshotData =
                      (cartSnapshot.data as Event).snapshot.value;
                  var _cartData = _cartSnapshotData['cart'];
                  var _cart = _cartData == null
                      ? <String, dynamic>{}
                      : Map<String, dynamic>.from(_cartData);
                  num _summ = 0;
                  for (int i = 0; i < _cart.length; i++) {
                    int _productIndex = int.parse(_cart.keys.elementAt(i).substring(8));
                    _summ = _summ +
                        _cart[_cart.keys.elementAt(i)] *
                            _products[_productIndex]['price'];
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _cartData == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'graphics/emptyCart.png',
                                        height: 150,
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        'В корзине нет товаров',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: LightColor.text),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _cart.keys.length + 1,
                                  itemBuilder: (ctx, i) {
                                    if (i == 0) return SizedBox(height: 15);
                                    int _productIndex = int.parse(
                                        _cart.keys.elementAt(i - 1).substring(8));
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 25),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: Container(
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'graphics/placeholder.png',
                                                      image: _products[
                                                              _productIndex]
                                                          ['image'],
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${_products[_productIndex]['title']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                ),
                                                Text(
                                                  "${_products[_productIndex]['price']} баллов",
                                                ),
                                                SizedBox(height: 15),
                                                MyCounter(
                                                    _cart[_cart.keys
                                                        .elementAt(i - 1)],
                                                    _productIndex),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "ИТОГО",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: LightColor.textSecondary,
                                        ),
                                  ),
                                  Text(
                                    "$_summ баллов",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: LightColor.text,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                child: ElevatedButton(
                                  child: Text(
                                    "КУПИТЬ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .copyWith(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    var _userCoins = _cartSnapshotData['coins'];
                                    if (_userCoins < _summ || _summ == 0) {
                                      return;
                                    }
                                    await MetricaPlugin.reportEvent(
                                        'Пользователь перешел к оформлению заказа');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => CheckOutPage()),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            LightColor.accent),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(LightColor.accent),
                    ),
                  );
                }
              },
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

  void _showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class MyCounter extends StatefulWidget {
  int currentAmount;
  int index;

  MyCounter(this.currentAmount, this.index);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LightColor.accent,
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          onTap: () async {
            var _cartRef =
                _database.child('users/${_auth.currentUser!.uid}/cart/');
            if (widget.currentAmount > 1)
              await _cartRef.update(
                  {'product_${widget.index}': widget.currentAmount - 1});
            else
              await _cartRef.update({'product_${widget.index}': null});
            setState(() {});
          },
        ),
        SizedBox(width: 15),
        Text(
          "${widget.currentAmount}",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(width: 15),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LightColor.accent,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onTap: () async {
            var _cartRef =
                _database.child('users/${_auth.currentUser!.uid}/cart/');
            if (widget.currentAmount < 1000) await _cartRef
                .update({'product_${widget.index}': widget.currentAmount + 1});
            setState(() {});
          },
        ),
      ],
    );
  }
}
