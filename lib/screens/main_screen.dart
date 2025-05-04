import 'package:chat_app_2/screens/auth_screen.dart';
import 'package:chat_app_2/screens/unauth_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_2/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return auth.isAuthenticated ? AuthScreen() : UnauthScreen();
  }
}
