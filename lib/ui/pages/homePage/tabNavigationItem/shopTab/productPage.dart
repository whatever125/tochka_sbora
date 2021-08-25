import 'package:flutter/material.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final int price;
  final String image;
  final String tag;

  ProductPage({
    required this.title,
    required this.price,
    required this.image,
    required this.tag,
  });

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
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'graphics/placeholder.png',
                          image: widget.image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  tag: widget.tag,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: LightColor.text),
                ),
                Text(
                  'В наличии',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: LightColor.textSecondary),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Состав набора: 1 - мед донниковый 150 г; 2 - крем-мед с облепихой 130 г; 3 - варенье из сосновой шишки 100 мл',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
          'В корзину за ${widget.price}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
