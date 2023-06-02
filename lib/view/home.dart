import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/constants/routes.dart';
import 'package:mealappflutter/main.dart';
import 'package:mealappflutter/services/auth/bloc/auth_bloc.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';
import 'package:mealappflutter/services/auth/bloc/auth_state.dart';
import 'package:mealappflutter/services/auth/firebase_auth_provider.dart';
import 'package:mealappflutter/utilities/dialogs/logout_dialog.dart';
import 'package:mealappflutter/view/details.dart';
import 'package:mealappflutter/view/forget_password.dart';
import 'package:mealappflutter/view/login.dart';
import 'package:mealappflutter/view/navbar.dart';
import 'package:mealappflutter/view/register.dart';
import 'package:mealappflutter/view/verify_email.dart';
import 'package:mealappflutter/view/welcome.dart';

void main() {
  //initialize widgets
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Navbar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //instance of bloc
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MainStateView(),
      ),
    ),
  );
}

class MainStateView extends StatelessWidget {
  const MainStateView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLOgin) {
          return NavClass();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateorgotPasseord) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
      listener: (context, state) {},
    );
  }
}
