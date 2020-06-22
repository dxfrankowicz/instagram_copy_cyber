import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insta_cyber/generated/l10n.dart';
import 'package:insta_cyber/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [const Locale('en', 'US'), const Locale('pl', 'PL'), const Locale('ru', 'RU')],
        title: 'Insta Cyber',
        debugShowCheckedModeBanner: false,
        home: LoginPage()
    );
  }
}