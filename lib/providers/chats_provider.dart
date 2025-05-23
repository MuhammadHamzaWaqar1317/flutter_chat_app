import 'package:chat_app_2/services/chats_service.dart';
import 'package:flutter/material.dart';

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

  Future<void>deleteMessage(String messageId)async{
    _singleChatMessages.removeWhere((chat) => chat['_id'] == messageId);
    print(_singleChatMessages);
    notifyListeners();
  }


}