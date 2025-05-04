import 'package:chat_app_2/services/chats_service.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:chat_app_2/services/auth_service.dart';

class ChatsProvider with ChangeNotifier {
  List<dynamic> _chats = [];
  List<dynamic> _singleChatMessages=[];
  List get chats => _chats;
  List get singleChatMessages => _singleChatMessages;

  Future<void>getchats()async{
    _chats=await ChatsService.getChats();
    notifyListeners();
  }

  Future<void>sendMessage(String receiverId,String text)async{
    await ChatsService.sendMessage(receiverId, text);
  }

  Future<void>getChatMessages(String receiverId)async{
    _singleChatMessages=await ChatsService.getChatMessages(receiverId);
    notifyListeners();
  }

  Future<void>addMessage(dynamic message)async{
    _singleChatMessages=[..._singleChatMessages,message];
    notifyListeners();
  }


}