import 'package:flutter/material.dart';
import 'package:chat_app_2/widgets/send_message_widget.dart';
import 'package:chat_app_2/widgets/navbar_widget.dart';
import 'package:chat_app_2/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_2/providers/chats_provider.dart';
import 'package:chat_app_2/providers/auth_provider.dart';
import 'package:chat_app_2/utils/retreive_token.dart';
import 'package:chat_app_2/widgets/chat_bubble_widget.dart';

class SingleChatPage extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  const SingleChatPage(
      {super.key, required this.receiverId, required this.receiverName});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  @override
  void initState() {
    super.initState();
    final socketService = SocketService();
    // socketService.initSocket();

    final chatsProvider = Provider.of<ChatsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    chatsProvider.getChatMessages(widget.receiverId);
    socketService.on('send_new_message', (data) {

      bool senderSideCondition = data['senderId'] == authProvider.authUserId &&
          data['receiverId'] == widget.receiverId;
      bool receiverSideCondition = data['receiverId'] == authProvider.authUserId &&
          data['senderId'] == widget.receiverId;

      if (senderSideCondition || receiverSideCondition) {
        chatsProvider.addMessage(data);
      }
    });

    socketService.on('message_deleted', (data) {
      chatsProvider.deleteMessage(data['messageId']);
      print('deleted Msg ID $data');
    });
  }

  @override
  void dispose() {
    // Remove listeners when the page is disposed
    final socketService = SocketService();
    socketService.socket.off('send_new_message');
    socketService.socket.off('message_deleted');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(title: widget.receiverName),
      body: ChatBubbleWidget(),
      bottomSheet: SendMessageWidget(
        receiverId: widget.receiverId,
      ),
    );
  }
}
