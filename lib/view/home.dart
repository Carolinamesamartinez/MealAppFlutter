import 'package:flutter/material.dart';
import 'package:mealappflutter/constants/routes.dart';
import 'package:mealappflutter/main.dart';
import 'package:mealappflutter/view/details.dart';
import 'package:mealappflutter/view/forget_password.dart';
import 'package:mealappflutter/view/register.dart';
import 'package:mealappflutter/view/verify_email.dart';
import 'package:mealappflutter/view/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navbar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeView(),
    );
  }
}

class NavClass extends StatefulWidget {
  @override
  _NavClassState createState() => _NavClassState();
}

class _NavClassState extends State<NavClass> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), ScreenThree()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Test',
          ),
        ],
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Test'),
    );
  }
}
