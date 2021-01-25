import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/pages/home.dart';
import 'package:flutter_chat/pages/chat.dart';
import 'package:flutter_chat/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      title: 'RN&YF Message',
      theme: ThemeData(
        primarySwatch: white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/message': (context) => MessagePage(),
      },
      initialRoute: '/home',
    );
  }
}
