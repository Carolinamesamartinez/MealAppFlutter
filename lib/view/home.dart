import 'package:flutter/material.dart';
import 'package:mealappflutter/constants/routes.dart';
import 'package:mealappflutter/main.dart';
import 'package:mealappflutter/view/details.dart';
import 'package:mealappflutter/view/forget_password.dart';
import 'package:mealappflutter/view/login.dart';
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
      home: RegisterView(),
    );
  }
}

class NavClass extends StatefulWidget {
  @override
  _NavClassState createState() => _NavClassState();
}

class _NavClassState extends State<NavClass> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Home(), ScreenThree(), ScreenThree()];

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
            icon: IconButton(
              icon: Icon(Icons.login),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              },
            ),
            label: 'Cerrar sesión',
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
