import 'package:flutter/material.dart';

import 'package:flutter_chat/pages/contact.dart';
import 'package:flutter_chat/pages/home.dart';
import 'package:flutter_chat/pages/chat.dart';

Map<String, Widget Function(BuildContext)> pageRouteTable = {
  '/home': (context) => HomePage(),
  '/message': (context) => MessagePage(),
  '/contact': (context) => ContactPage(),
};

/// Build Navigation bar of home page.
///
/// `currentIndex` is current page index,
/// `context` is BuildContext.
Widget buildNavBar(int currentIndex, BuildContext context) {
  return BottomNavigationBar(
    selectedItemColor: Colors.lightBlue,
    currentIndex: currentIndex,
    onTap: (i) {
      const List<String> pages = ['/home', '/contact', '/home'];
      // We disable page route transition of pages in nav bar.
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              pageRouteTable[pages[i]](context),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
      BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: '联系人'),
      BottomNavigationBarItem(icon: Icon(Icons.camera), label: '动态')
    ],
  );
}
