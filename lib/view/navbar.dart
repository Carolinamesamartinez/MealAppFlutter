import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/main.dart';
import 'package:mealappflutter/service/api_service.dart';
import 'package:mealappflutter/utilities/dialogs/logout_dialog.dart';
import 'package:mealappflutter/view/random.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

class NavClass extends StatefulWidget {
  @override
  _NavClassState createState() => _NavClassState();
}

class _NavClassState extends State<NavClass> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), RandomMeal(), ScreenThree()];

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
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_and_archive),
            label: 'uwu',
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
