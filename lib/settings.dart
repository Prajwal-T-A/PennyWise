import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings and Profile"),
        backgroundColor: const Color.fromARGB(255, 98, 69, 132),
      ),
      backgroundColor: Colors.black,
    );
  }
}
