import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

//we dont nead a bloclistener because we dont do anything extra to bloc only events , for example we dont send the event any text we dont do any changues in the bloc
class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Te hemos enviado un email de verificación,porfavor revisa tu bandeja de entrada',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventSendEmailVerification());
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
                    'No me ha llegado',
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
    );
  }
}
