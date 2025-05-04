import 'package:chat_app_2/pages/auth_pages/single_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_2/providers/chats_provider.dart';
import 'package:chat_app_2/providers/auth_provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    final chatsProvider = Provider.of<ChatsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    chatsProvider.getchats();
    authProvider.setAuthUserId();
  }

  @override
  Widget build(BuildContext context) {
    void _openChat(String receiverId, String receiverName) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SingleChatPage(
                    receiverId: receiverId,
                    receiverName: receiverName,
                  )));
    }

    return Scaffold(
      body: Consumer<ChatsProvider>(
        builder: (context, chats, child) {
          if (chats.chats.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: chats.chats.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(chats.chats[index]);
                    final receiverId = chats.chats[index]['_id'];
                    final name = chats.chats[index]['name'];
                    return GestureDetector(
                      onTap: () => _openChat(receiverId, name),
                      child: ListTile(
                        leading: CircleAvatar(child: Text('H')),
                        title: Text(name),
                        subtitle: Text('Longer supporting text .'),
                        trailing: Icon(Icons.favorite_rounded),

                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
