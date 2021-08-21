import 'package:flutter/material.dart';
import 'package:tochka_sbora/ui/pages/splashPage.dart';
import 'package:tochka_sbora/ui/themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tochka_sbora/helper/services/local_storage_service.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: MaterialApp(
          title: 'Точка сбора',
          home: SplashPage(),
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ru', 'RU'),
          ],
          locale: const Locale('ru', 'RU'),
        ),
    );
  }
}
