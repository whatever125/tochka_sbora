import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class ProductPage extends StatefulWidget {
  final name;
  final price;
  final image;

  const ProductPage(
      {required Key key, this.name, this.price, this.image})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Купить товар', style: TextStyle(color: LightColor.text)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.image,
            widget.name,
            widget.price,
            Text('Есть в наличии'),
          ],
        )
      ),
    );
  }
}
