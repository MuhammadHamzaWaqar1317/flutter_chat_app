import 'package:flutter/material.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const Navbar({super.key,required this.title});

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purpleAccent,
    );
  }
}
