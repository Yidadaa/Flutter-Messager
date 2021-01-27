import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.search, color: Colors.grey, size: 20),
                Text('搜索', style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
