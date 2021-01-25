import 'package:flutter/material.dart';
import 'package:flutter_chat/components/avatar.dart';

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

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                Text(
                  '搜索',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightBlue,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: '联系人'),
        BottomNavigationBarItem(icon: Icon(Icons.camera), label: '动态')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildListView(),
          )
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }
}
