import 'package:flutter/material.dart';
import 'package:hamrahpolice1/root.dart';
import 'file:///G:/FlutterProjects/hamrahpolice1/lib/login/logIn1.dart';
import 'file:///G:/FlutterProjects/hamrahpolice1/lib/login/signUp.dart';
import 'Splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // MyApp({
  //   Key key,
  // }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      // این قسمت مربوط به navigation است در این جا صفحات ای که میریم رو تعریف میکنیم
      routes: {
        // به جای استفاده از home میتوانیم از این route استفاده کنیم
        '/login': (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: LogIn1(),
        ),
        '/signUp': (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: SignUp(),
        ),
        '/splash_screen': (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: SplashScreen(),
        ),
        '/': (context) => Directionality(
          textDirection: TextDirection.rtl,
          child: Root(),
        ),
        // '/setting': (context) => SettingScreen(),
        // '/new_chat': (context) => CreateChatScreen(),
      },
    );
  }
}
