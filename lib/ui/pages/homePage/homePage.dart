import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'tabNavigationItem/tabNavigationItem.dart';
import 'tabNavigationItem/shopTab/cartPage/cartPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _database = FirebaseDatabase(
    app: Firebase.apps.first,
    databaseURL:
        'https://devtime-cff06-default-rtdb.europe-west1.firebasedatabase.app',
  ).reference();
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 2;
  late Future<bool> _admin;

  @override
  void initState() {
    super.initState();
    _admin = _isAdmin();
    MetricaPlugin.reportEvent("HomePage");
  }

  Future<bool> _isAdmin() async {
    final _user = _auth.currentUser;
    final _uid = _user!.uid;
    final _isAdminRef = _database.child('users/$_uid/isAdmin/');
    return _isAdminRef.once().then((snapshot) {
      var _data = snapshot.value;
      return _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _admin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'graphics/name.png',
                fit: BoxFit.cover,
                height: 32,
              ),
              actions: _currentIndex == 0
                  ? [
                      IconButton(
                        icon: Icon(Icons.shopping_basket),
                        onPressed: () async {
                          await MetricaPlugin.reportEvent("Пользователь открыл корзину");
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
                for (final tabItem in TabNavigationItem.items
                    .take(snapshot.data == true ? 5 : 3))
                  tabItem.page,
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) => setState(() => _currentIndex = index),
              items: [
                for (final tabItem in TabNavigationItem.items
                    .take(snapshot.data == true ? 5 : 3))
                  BottomNavigationBarItem(
                    icon: tabItem.icon,
                    activeIcon: tabItem.activeIcon,
                    label: tabItem.label,
                  ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(LightColor.accent),
              ),
            ),
          );
        }
      },
    );
  }
}
