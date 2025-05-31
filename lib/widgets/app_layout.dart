import 'package:flutter/material.dart';

import 'package:cyircle_app/screens/home_screen.dart';
import 'package:cyircle_app/services/auth_services.dart';
import 'package:cyircle_app/widgets/theme_mode_button.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  var _currentTabIndex = 0;

  final _screens = [
    const HomeScreen(),
    const Text("Explore"),
    const Text("Categories"),
    const Text("Profile"),
  ];
  final _bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ThemeModeButton(),
          IconButton(
            onPressed: () {
              final authServices = AuthServices();
              authServices.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(index: _currentTabIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentTabIndex,
        onTap: (value) {
          setState(() {
            _currentTabIndex = value;
          });
        },
        items: _bottomNavigationItems,
      ),
    );
  }
}
