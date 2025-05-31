import 'package:cyircle_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final authServices = AuthServices();
              authServices.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Text("Home page"),
    );
  }
}
