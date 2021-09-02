import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/shopTab/cartPage/chooseShopPage.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'SMSCheckPage.dart';

final _database = FirebaseDatabase(
  app: Firebase.apps.first,
  databaseURL:
      'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
).reference();
final _auth = FirebaseAuth.instance;

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late Future<dynamic> _shopData;

  @override
  void initState() {
    super.initState();
    _shopData = _getShopData();
  }

  _getShopData() async {
    var _data = await StorageManager.readData('shop');
    return 0;
    // return _data == null ? -1 : _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Оформление заказа',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: _shopData,
        builder: (context, shopSnapshot) {
          if (shopSnapshot.hasData) {
            int _shop = shopSnapshot.data;
            return StreamBuilder(
              stream: _database.child('products/').onValue,
              builder: (context, productsSnapshot) {
                if (productsSnapshot.hasData) {
                  var _products = List<dynamic>.from(
                      (productsSnapshot.data as Event).snapshot.value);
                  return StreamBuilder(
                    stream: _database
                        .child('users/${_auth.currentUser!.uid}/')
                        .onValue,
                    builder: (context, cartSnapshot) {
                      if (cartSnapshot.hasData) {
                        var _userData =
                            (cartSnapshot.data as Event).snapshot.value;
                        var _cartData = _userData['cart'];
                        var _cart = _cartData == null
                            ? <String, dynamic>{}
                            : Map<String, dynamic>.from(_cartData);
                        num _summ = 0;
                        for (int i = 0; i < _cart.length; i++) {
                          int _productIndex =
                              int.parse(_cart.keys.elementAt(i)[8]);
                          _summ = _summ +
                              _cart[_cart.keys.elementAt(i)] *
                                  _products[_productIndex]['price'];
                        }
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Адрес доставки',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: LightColor.text),
                              ),
                              _shop < 0
                                  ? TextButton(
                                      onPressed: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         ChooseShopPage(),
                                        //   ),
                                        // );
                                      },
                                      child: Text('Выбрать магазин'),
                                    )
                                  : StreamBuilder(
                                      stream: _database
                                          .child('shops/$_shop')
                                          .onValue,
                                      builder: (context, shopDataSnapshot) {
                                        if (shopDataSnapshot.hasData) {
                                          var _shopAddressData =
                                              Map<String, dynamic>.from(
                                                  (shopDataSnapshot.data
                                                          as Event)
                                                      .snapshot
                                                      .value);
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15),
                                              Text(
                                                'Адрес магазина',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      LightColor.textSecondary,
                                                ),
                                              ),
                                              Text(
                                                _shopAddressData['address'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: LightColor.text,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Время работы',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      LightColor.textSecondary,
                                                ),
                                              ),
                                              Text(
                                                _shopAddressData[
                                                    'workingHours'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: LightColor.text,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         ChooseShopPage(),
                                                  //   ),
                                                  // );
                                                },
                                                child: Text('Изменить'),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      LightColor.accent),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                              SizedBox(height: 15),
                              Text(
                                'Товары',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: LightColor.text),
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _cart.keys.length + 1,
                                itemBuilder: (ctx, i) {
                                  if (i == 0) return SizedBox(height: 15);
                                  int _productIndex =
                                      int.parse(_cart.keys.elementAt(i - 1)[8]);
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 75,
                                          height: 75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'graphics/placeholder.png',
                                                  image:
                                                      _products[_productIndex]
                                                          ['image'],
                                                  fit: BoxFit.fitWidth,
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
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: LightColor.text),
                                              ),
                                              Text(
                                                "${_products[_productIndex]['price']} баллов",
                                                style: TextStyle(
                                                  color: LightColor.text,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          'x${_cart[_cart.keys.elementAt(i - 1)]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: LightColor.accent,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          "ПОДТВЕРДИТЬ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button!
                                              .copyWith(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          if (await _verifyPhoneNumber()) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SMSCheckPage(),
                                            ),
                                          );
                                          }
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                LightColor.accent),
                          ),
                        );
                      }
                    },
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

  Future<bool> _verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      _showSnackbar('Автоматический вход: ${_auth.currentUser!.uid}');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      _showSnackbar(
          'Код ошибки: ${authException.code}. Сообщение: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _showSnackbar(
          'На ваш номер телефона отправлено СМС с шестизначным кодом');
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      StorageManager.saveData('verificationId', verificationId);
    };

    try {
      _auth.setLanguageCode("ru");
      await _auth.verifyPhoneNumber(
        phoneNumber: _auth.currentUser!.phoneNumber!,
        timeout: const Duration(seconds: 0),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      _showSnackbar("SignIn Ошибка: $e");
      return false;
    }
    return true;
  }

  void _showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
