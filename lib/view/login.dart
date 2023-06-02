import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/services/auth/auth_exceptions.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';
import 'package:mealappflutter/services/auth/bloc/auth_state.dart';
import 'package:mealappflutter/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        //if there is not yet a user log in
        if (state is AuthStateLoggedOut) {
          if (state.excption is UserNotFound) {
            await showErrorDialog(
                context, 'cannot find a user with those credentials');
          } else if (state.excption is WrongPassword) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.excption is GenericAuthException) {
            await showErrorDialog(context, 'Wrong ');
          }
        }
      },
      child: Scaffold(
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
                  '!Vamos inicia sesión',
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
                  controller: _email,
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
                  controller: _password,
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
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventLogin(email, password));
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
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegsiter());
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 204, 140, 136)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventForgotPassword());
                    // Lógica del botón
                  },
                  child: Text(
                    'Contraseña olvidada',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 204, 140, 136)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
