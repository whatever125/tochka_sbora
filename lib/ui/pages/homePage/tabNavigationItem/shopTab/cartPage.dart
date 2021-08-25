import 'package:flutter/material.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class Product {
  String image;
  String title;
  String price;

  Product({
    required this.price,
    required this.image,
    required this.title,
  });
}

List<Product> bag = [
  Product(
    title: 'Подарочный набор "С бородой"',
    price: '800 баллов',
    image:
    'https://static.tildacdn.com/tild3166-6266-4165-a131-323063343530/__.jpg',
  ),
  Product(
    title: 'Пастила Ассорти с ягодами, бананом и яблоком',
    price: '299 баллов',
    image:
    'https://static.tildacdn.com/tild6639-3236-4637-b966-336131323964/__.jpg',
  ),
  Product(
    title: 'Подарочный набор "Сердце"',
    price: '949 баллов',
    image:
    'https://static.tildacdn.com/tild3432-3334-4166-a261-303232376235/80004.jpg',
  ),
  Product(
    title: 'Подарочный набор "С цветами"',
    price: '800 баллов',
    image:
    'https://static.tildacdn.com/tild3563-6138-4135-b134-373330303630/__.jpg',
  ),
  Product(
    title: 'Подарочный набор "Шкатулка"',
    price: '1004 баллов',
    image:
    'https://static.tildacdn.com/tild6131-6239-4231-b866-623166613533/_.jpg',
  ),
  Product(
    title: 'Подарочный набор "Скворечник"',
    price: '761 баллов',
    image:
    'https://static.tildacdn.com/tild3636-3236-4563-a530-353163393238/_.jpg',
  ),
  Product(
    title: 'Подарочная карта Калина-Малина номинал 1000 р.',
    price: '1000 баллов',
    image:
    'https://static.tildacdn.com/tild3764-3432-4536-b830-633134313735/_1.jpg',
  ),
];

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(color: LightColor.text)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: bag.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'graphics/placeholder.png',
                                    image: bag[i].image,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${bag[i].title}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                "${bag[i].price}",
                              ),
                              SizedBox(height: 15),
                              MyCounter(),
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
                      Text("ИТОГО",
                          style: Theme.of(context).textTheme.subtitle2),
                      Text("1350 баллов",
                          style: Theme.of(context).textTheme.headline5),
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
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(LightColor.accent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter();

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () {
            setState(() {
              _currentAmount -= 1;
            });
          },
        ),
        SizedBox(width: 15),
        Text(
          "$_currentAmount",
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
          onTap: () {
            setState(() {
              _currentAmount += 1;
            });
          },
        ),
      ],
    );
  }
}
