import 'package:flutter/cupertino.dart';

@immutable
class MessageModel {
  final String senderName;
  final String message;
  final String messageData;
  final String dateMessage;
  final String profilePicture;

  MessageModel({ required this.senderName, required this.message, required this.messageData, required this.dateMessage, required this.profilePicture });
}