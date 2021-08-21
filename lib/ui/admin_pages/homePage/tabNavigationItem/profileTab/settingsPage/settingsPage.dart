import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/homePage/tabNavigationItem/profileTab/settingsPage/profileDataPage.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/admin_pages/homePage/tabNavigationItem/acceptTab/QRScannerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'infoPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  bool isAdmin() {
    return true;
    //TODO сделать запрос на проверку наличия статуса администратора
  }

  _logOutSP() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('logged_in', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: TextStyle(color: LightColor.text),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: LightColor.accent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Личные данные',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18, color: LightColor.text),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDataPage()),
                    ),
                  },
                ),
                if(isAdmin())
                TextButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.miscellaneous_services,
                          color: LightColor.accent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Режим администратора',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18, color: LightColor.text),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scanner()),
                    ),
                  },
                ),
                TextButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: LightColor.accent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Выйти',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18, color: LightColor.text),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    _logOutSP(),
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomePage()),
                            (Route<dynamic> route) => false
                    ),
                  },
                ),
                TextButton(
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: LightColor.accent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'О приложении',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18, color: LightColor.text),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoPage()),
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
