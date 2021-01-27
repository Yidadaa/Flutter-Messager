import 'package:flutter/material.dart';
import 'package:flutter_chat/components/avatar.dart';
import 'package:flutter_chat/components/nav.dart';
import 'package:flutter_chat/components/searchbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _itemCount = 10;

  void _navigateToMessagePage() {
    Navigator.of(context).pushNamed('/message');
  }

  Widget _buildListView() {
    List<Widget> lists = new List<Widget>();

    for (int i = 0; i < _itemCount; i += 1) {
      lists.add(InkWell(
          onTap: _navigateToMessagePage,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Avatar('assets/avatar.jpg', size: 54),
                Expanded(
                  child: Padding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '第 $i 个好友小魔仙',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              height: 1.5),
                        ),
                        Text(
                          '发来了 99+ 条消息',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                Text(
                  '$i 分钟之前',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          )));
    }
    return ListView(
      children: lists,
    );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'iYda',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '😍恋爱中',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            child: _buildListView(),
          )
        ],
      ),
      bottomNavigationBar: buildNavBar(0, context),
    );
  }
}
