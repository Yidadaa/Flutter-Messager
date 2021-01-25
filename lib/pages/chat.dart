import 'package:flutter/material.dart';
import 'package:flutter_chat/components/avatar.dart';
import 'package:flutter_chat/model/message.dart';
import 'dart:math';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final String _chatWith = '阿巴巴小魔仙';
  final int _messageCount = 20;
  List<Message> _messages = new List<Message>();

  // 用于获取用户文字输入
  TextEditingController _editingController = new TextEditingController();

  // 控制消息显示
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    for (int i = 0; i < _messageCount; i += 1) {
      _messages.add(Message(
          Random().nextBool(), '随便一条消息 $i' * (1 + Random().nextInt(5))));
    }
    setState(() {});
  }

  void _sendMessage(String msg) {
    setState(() {
      _messages.add(Message(true, msg));
    });
  }

  Widget _buildMessageLine(Message msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: msg.isFromMe ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Avatar('assets/avatar.jpg'),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  color: msg.isFromMe ? Colors.lightBlueAccent : Colors.white,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: Text(
                      msg.content,
                      style: TextStyle(
                          fontSize: 16,
                          color: msg.isFromMe ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
        // color: Colors.white,
        padding: EdgeInsets.only(left: 20, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _editingController,
                minLines: 1,
                maxLines: 6,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: '说点什么'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send_rounded),
              onPressed: () {
                String msg = _editingController.text;
                if (msg.length > 0) {
                  _sendMessage(msg);
                  _editingController.clear();
                }
              },
            )
          ],
        ));
  }

  Widget _buildChatBody() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          return _buildMessageLine(_messages[_messages.length - 1 - index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            _chatWith,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: _buildChatBody(),
              ),
            ),
            _buildInputBar()
          ],
        ));
  }
}
