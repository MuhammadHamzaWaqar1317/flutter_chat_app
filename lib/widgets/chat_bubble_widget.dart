import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_2/providers/chats_provider.dart';
import 'package:chat_app_2/providers/auth_provider.dart';

class ChatBubbleWidget extends StatefulWidget {
  const ChatBubbleWidget({super.key});

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsProvider>(
      builder: (context, chats, child) {
        // if (chats.singleChatMessages.isEmpty) {
        //   return Center(child: CircularProgressIndicator());
        // }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: chats.singleChatMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  final receiverId =
                  chats.singleChatMessages[index]['receiverId'];
                  final senderId =
                  chats.singleChatMessages[index]['senderId'];
                  final textMessage =
                  chats.singleChatMessages[index]['text'];
                  final authUserId =
                      Provider.of<AuthProvider>(context, listen: false)
                          .authUserId;
                  bool isMe = authUserId == senderId;
                  return GestureDetector(
                    // onTap: () => _openChat(receiverId, name),
                      child: Align(
                        alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "$textMessage",
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
