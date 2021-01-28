import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat/components/avatar.dart';
import 'package:flutter_chat/components/nav.dart';
import 'package:flutter_chat/components/searchbar.dart';
import 'package:flutter_chat/model/user.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/services.dart';

import 'dart:math';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ItemScrollController _itemScrollController = ItemScrollController();
  List<MapEntry<String, List<User>>> _contacts;
  Map<String, GlobalKey> _sideLocatorKeys = {};
  String _touchingKey;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    List<MapEntry> groupedContacts = Iterable.generate(26).map((i) {
      String key = String.fromCharCode(i + 65);
      _sideLocatorKeys[key] = GlobalKey();
      List<User> users = Iterable.generate(Random().nextInt(5) + 1)
          .map((ui) => User('用户名称 $i _$ui', 'assets/avatar.jpg',
              motto: '名人名言' * Random().nextInt(4)))
          .toList();
      return MapEntry(key, users.toList());
    }).toList();

    setState(() {
      _contacts = groupedContacts;
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: Avatar('assets/avatar.jpg', size: 36),
          ),
          Expanded(
            child: Text(
              '联系人',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person_add_alt),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildActionPanel() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: ListTile(
            onTap: () {},
            title: Text('新朋友', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.keyboard_arrow_right),
          )),
    );
  }

  Widget _buildContactList() {
    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Row(children: [
          Expanded(
              child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    String _listKeyString = _contacts[index].key;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // header text
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            child: Text(_listKeyString,
                                style: TextStyle(color: Colors.black45)),
                          ),
                          Column(
                            // grouped contacts
                            children: _contacts[index]
                                .value
                                .map((user) => ListTile(
                                      leading: Avatar(
                                        user.avatar,
                                        size: 45,
                                      ),
                                      title: Text(user.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Text(user.motto ?? '在线中',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      onTap: () {},
                                    ))
                                .toList(),
                          ),
                        ]);
                  })),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (details) {
                print('start');
              },
              onPanUpdate: (details) {
                MapEntry touchedKey =
                    _sideLocatorKeys.entries.firstWhere((gKey) {
                  // Transform global position and check if the pointer inside the box
                  RenderBox box = gKey.value.currentContext.findRenderObject();
                  Offset local = box.globalToLocal(details.globalPosition);
                  return local.dy > 0 && local.dy < box.paintBounds.bottom;
                }, orElse: () => null);
                if (touchedKey != null && _touchingKey != touchedKey.key) {
                  setState(() {
                    _touchingKey = touchedKey.key;
                  });
                  // Jump to responding item group
                  _itemScrollController.jumpTo(
                      index: _touchingKey.codeUnitAt(0) - 65);
                  // HapticFeedback.vibrate();
                  HapticFeedback.lightImpact();
                }
              },
              onPanEnd: (details) {
                // Clear touching key
                setState(() {
                  _touchingKey = null;
                });
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _contacts
                      .map((contact) => Padding(
                            key: _sideLocatorKeys[contact.key],
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              contact.key,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: contact.key == _touchingKey
                                      ? Colors.lightBlue
                                      : Colors.black54),
                            ),
                          ))
                      .toList())),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildNavBar(1, context),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchBar(),
          _buildActionPanel(),
          Expanded(
            child: _buildContactList(),
          )
        ],
      ),
    );
  }
}
