import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';
import 'package:mealappflutter/services/auth/bloc/auth_state.dart';
import 'package:mealappflutter/utilities/dialogs/error_dialog.dart';
import 'package:mealappflutter/utilities/dialogs/password_root_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateorgotPasseord) {
          //if the user press the button to send it
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          //the email given in the texfield is not register
          if (state.exception != null) {
            await showErrorDialog(context,
                'we could not process it make sure that you are registered user');
          }
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 188, 188),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.food_bank_rounded,
                    size: 210,
                    color: Color.fromARGB(255, 204, 140, 136),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Introduce tu correo para reiniciar la contraseña, te llegará un email ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
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
                  ElevatedButton(
                    onPressed: () {
                      final email = _controller.text;
                      context
                          .read<AuthBloc>()
                          .add(AuthEventForgotPassword(email: email));
                      // Lógica del botón
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5, // Sombrado
                      backgroundColor:
                          Color.fromARGB(255, 218, 134, 162), // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Envíamelo',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());

                      // Lógica del botón
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5, // Sombrado
                      backgroundColor:
                          Color.fromARGB(255, 218, 134, 162), // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Volver',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
