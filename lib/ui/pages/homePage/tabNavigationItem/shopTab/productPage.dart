import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';

class ProductPage extends StatefulWidget {
  late final id;

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
          children: [

          ],
        )
      ),
    );
  }
}
