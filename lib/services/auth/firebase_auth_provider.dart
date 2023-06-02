import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealappflutter/firebase_options.dart';
import 'package:mealappflutter/services/auth/auth_exceptions.dart';
import 'package:mealappflutter/services/auth/auth_provider.dart';
import 'package:mealappflutter/user/auth_user.dart';

class FirebaseAuthProvider implements AuthProvider {
  //logic of authprovider
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      //create the user
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      //we call the method currentuser to get it if the user given is not null we return that user
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedin();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUse();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmail();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    //configure and initialize the conecction with firebase services
    await Firebase.initializeApp(
      //options is tthe object that give us the options for out currentplatform
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedin();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound();
      } else if (e.code == 'wrong-password') {
        throw WrongPassword();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    //we get the currente user with that method , if this is not null we sign out it
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedin();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    //we get the currente user with that method , if this is not null we send that email verification
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification();
    } else {
      throw UserNotLoggedin();
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      //we have a textfield that the user write his email and with this email that is given to us with string to email
      //we send a password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      //but if the user is not correct or is not found we gave exceptions
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmail();
        case 'firebase_auth/user-not-found':
          throw UserNotFound();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  //get the current user of the app , is this is not null we return that user fromfirebase(with that sintax)
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }
}
