import 'package:flutter/material.dart';

void main() {
  runApp(CyircleApp());
}

class CyircleApp extends StatelessWidget {
  const CyircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cyircle Application",
      home: Scaffold(body: const Text("Welcome to cyircle app!")),
    );
  }
}
