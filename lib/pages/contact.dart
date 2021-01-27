import 'package:flutter/material.dart';
import 'package:flutter_chat/components/avatar.dart';
import 'package:flutter_chat/components/nav.dart';
import 'package:flutter_chat/components/searchbar.dart';
import 'package:flutter_chat/model/user.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'dart:math';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<MapEntry<String, List<User>>> _contacts;
  String _currentHeaderKey = 'A';

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    List<MapEntry> groupedContacts = Iterable.generate(26).map((i) {
      List<User> users = Iterable.generate(Random().nextInt(5) + 1)
          .map((ui) => User('用户名称 $i _$ui', 'assets/avatar.jpg',
              motto: '名人名言' * Random().nextInt(4)))
          .toList();
      return MapEntry(String.fromCharCode(i + 65), users.toList());
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
    return Row(children: [
      Expanded(
          child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                setState(() {});
                return true;
              },
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return StickyHeaderBuilder(
                      builder: (context, amount) {
                        // set current header key
                        if (amount >= 0 && amount < 0.1) {
                          _currentHeaderKey = _contacts[index].key;
                        }
                        return Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          color: Colors.white,
                          child: Text(
                            _contacts[index].key,
                            style: TextStyle(
                                color: amount < 0.1
                                    ? Colors.lightBlue
                                    : Colors.black45),
                          ),
                        );
                      },
                      content: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: Column(
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
                      ));
                },
              ))),
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _contacts
              .map((contact) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    child: Text(
                      contact.key,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _currentHeaderKey == contact.key
                              ? Colors.lightBlue
                              : Colors.black54),
                    ),
                  ))
              .toList())
    ]);
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
