import 'package:flutter/material.dart';

import 'tabNavigationItem/tabNavigationItem.dart';
import 'tabNavigationItem/shopTab/cartPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'graphics/name.png',
              fit: BoxFit.cover,
              height: 32,
            ),
          ],
        ),
        actions: _currentIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.card_travel),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                )
              ]
            : [],
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              activeIcon: tabItem.activeIcon,
              label: tabItem.label,
            ),
        ],
      ),
    );
  }
}
