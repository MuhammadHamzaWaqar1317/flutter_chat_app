import 'package:chat_app_2/services/chats_service.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:chat_app_2/services/auth_service.dart';

class ChatsProvider with ChangeNotifier {
  List<dynamic> _chats = [];
  List get chats => _chats;

  Future<void>getchats()async{
    _chats=await ChatsService.getChats();
  }



}