import 'package:chat_app_2/providers/chats_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatefulWidget {
  final String receiverId;
  const SendMessageWidget({super.key,required this.receiverId});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController messageController = TextEditingController();
  bool disableSendBtn = true;

  void _handleText(String text) {
    setState(() {
      disableSendBtn = text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final message=Provider.of<ChatsProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(

        children: [
          Expanded(
            child: TextField(
              onChanged: _handleText,
              controller: messageController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color:disableSendBtn?Colors.grey: Colors.purpleAccent),
            onPressed: () {
              if(!messageController.text.trim().isEmpty){
                message.sendMessage(widget.receiverId, messageController.text.trim());
                messageController.text='';
                setState(() {
                  disableSendBtn = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
