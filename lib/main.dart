import 'package:flutter/material.dart';
import 'package:goodplays/screens/home_screen.dart';
import 'package:goodplays/views/bottom_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodplays',
      debugShowCheckedModeBanner: false,
      home: AppScaffold(),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
