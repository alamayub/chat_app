import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({Key? key, required this.messageModel}) : super(key: key);

  final MessageModel messageModel;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
