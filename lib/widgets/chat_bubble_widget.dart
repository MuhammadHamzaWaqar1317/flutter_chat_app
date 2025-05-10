import 'package:chat_app_2/services/chats_service.dart';
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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: chats.singleChatMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  final messageId = chats.singleChatMessages[index]['_id'];
                  final receiverId = chats.singleChatMessages[index]['receiverId'];
                  final senderId = chats.singleChatMessages[index]['senderId'];
                  final textMessage = chats.singleChatMessages[index]['text'];
                  final authUserId = Provider.of<AuthProvider>(context, listen: false).authUserId;
                  bool isMe = authUserId == senderId;

                  return GestureDetector(
                    child: Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[600] : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "$textMessage",
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  ChatsService.deleteMessage(messageId);
                                },
                                child: Icon(Icons.delete, size: 18, color: Colors.white),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
