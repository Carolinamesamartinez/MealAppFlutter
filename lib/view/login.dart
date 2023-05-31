import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 241, 243),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '!Vamos registrate¡',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.food_bank_rounded,
                size: 210,
                color: Color.fromARGB(255, 204, 140, 136),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Lógica del botón
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5, // Sombrado
                  backgroundColor:
                      Color.fromARGB(255, 231, 188, 185), // Color del botón
                ),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Lógica del botón
                },
                child: Text(
                  'Registrate',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 204, 140, 136)),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Lógica del botón
                },
                child: Text(
                  'Contraseña olvidada',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 204, 140, 136)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
