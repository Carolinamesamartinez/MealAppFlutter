import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String idUser;
  final String email;
  final bool isemailVerified;

  AuthUser(
      {required this.idUser,
      required this.email,
      required this.isemailVerified});

  factory AuthUser.fromFirebase(User user) => AuthUser(
        idUser: user.uid,
        email: user.email!,
        isemailVerified: user.emailVerified,
      );
}
