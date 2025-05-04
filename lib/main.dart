import 'package:flutter/material.dart';
import 'package:chat_app_2/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_2/screens/main_screen.dart';
import 'package:chat_app_2/providers/chats_provider.dart';
import 'package:chat_app_2/services/socket_service.dart';

void main() {
  SocketService().initSocket();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatsProvider()),
      ],
      child: MyApp(),
    ),

  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
