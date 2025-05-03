import 'package:chat_app_2/pages/unauth_pages/login.dart';
import 'package:chat_app_2/pages/unauth_pages/signup_page.dart';
import 'package:flutter/material.dart';

class UnauthScreen extends StatefulWidget {
  const UnauthScreen({super.key});

  @override
  State<UnauthScreen> createState() => _UnauthScreenState();
}

class _UnauthScreenState extends State<UnauthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
