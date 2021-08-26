import 'package:flutter/material.dart';

import 'package:tochka_sbora/helper/services/local_storage_service.dart';
import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'package:tochka_sbora/ui/admin_pages/homePage/homePage.dart';
import 'infoPage.dart';
import 'profileDataPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isAdmin() {
    //TODO сделать запрос на проверку наличия статуса администратора
    return true;
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
                _generateTextButton(
                  icon: Icons.account_circle,
                  title: 'Личные данные',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileDataPage(),
                      ),
                    );
                  },
                ),
                if (_isAdmin())
                  _generateTextButton(
                    icon: Icons.miscellaneous_services,
                    title: 'Режим администратора',
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                _generateTextButton(
                  icon: Icons.logout,
                  title: 'Выйти',
                  onPressed: () async {
                    print(
                        "settings 1 ${await StorageManager.readData('loggedIn')}");
                    StorageManager.saveData('loggedIn', false);
                    print(
                        "settings 1 ${await StorageManager.readData('loggedIn')}");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomePage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                _generateTextButton(
                  icon: Icons.info,
                  title: 'О приложении',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InfoPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _generateTextButton({required icon, required title, required onPressed}) {
    return TextButton(
      child: Container(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              color: LightColor.accent,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 18, color: LightColor.text),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
