import 'package:flutter/material.dart';

import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/pages/homePage/homePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Future<dynamic> loggedIn;

  @override
  void initState() {
    super.initState();
    loggedIn = _getLoggedIn();
  }

  _getLoggedIn() async {
      var keyInStorage = await StorageManager.checkData('loggedIn');
      if (keyInStorage == false) {
        StorageManager.saveData('loggedIn', false);
      }
      return await StorageManager.readData('loggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loggedIn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return WelcomePage();
          }
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
