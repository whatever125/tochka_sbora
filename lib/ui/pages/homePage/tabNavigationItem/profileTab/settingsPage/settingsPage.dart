import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrica_plugin/metrica_plugin.dart';

import 'package:tochka_sbora/ui/themes/colors.dart';
import 'package:tochka_sbora/ui/pages/welcomePage.dart';
import 'infoPage.dart';
import 'profileDataPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    MetricaPlugin.reportEvent('Пользователь открыл настройки');
  }

  Future<void> _signOut() async {
    await _auth.signOut();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
            child: Column(
              children: [
                //TODO
                // _generateTextButton(
                //   icon: Icons.account_circle,
                //   title: 'Личные данные',
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => ProfileDataPage(),
                //       ),
                //     );
                //   },
                // ),
                _generateTextButton(
                  icon: Icons.logout,
                  title: 'Выйти',
                  onPressed: () async {
                    await _signOut();
                    await MetricaPlugin.reportEvent('Пользователь вышел из аккаунта');
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
