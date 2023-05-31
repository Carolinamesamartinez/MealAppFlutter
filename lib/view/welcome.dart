import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a tus recetitas',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 226, 179, 175)),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.food_bank_outlined,
              size: 270,
              color: Color.fromARGB(255, 204, 140, 136),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 150, // Ancho del botón
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica del primer botón
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5, // Sombrado
                  backgroundColor:
                      Color.fromARGB(255, 231, 188, 185), // Color del botón
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 150, // Ancho del botón
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica del segundo botón
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5, // Sombrado
                  backgroundColor:
                      Color.fromARGB(255, 231, 188, 185), // Color del botón
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
