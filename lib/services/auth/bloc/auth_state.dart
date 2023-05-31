import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:mealappflutter/user/auth_user.dart';

@immutable
abstract class AuthState {
  //all states that extends of authstate can be loading and have a loadingtext by default
  final bool isLoading;
  final String? loadingText;
  const AuthState(
      {required this.isLoading, this.loadingText = 'Please wait a moment'});
}

//unitialized firebase this state can be loading until is initialized
class AuthStateUnitialized extends AuthState {
  const AuthStateUnitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

//statet login -> after the user is given by texfields will be loading to log the user
class AuthStateLOgin extends AuthState {
  final AuthUser user;
  const AuthStateLOgin({required bool isLoading, required this.user})
      : super(isLoading: isLoading);
}

//state -> the user is going to register or login but in the booth cases doesnt verify and we will loading and give the verify view
class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

//when the user is log out=not login  we have exception,loading and loading text
//compare states of the object without == , compare two equals instances
//example= we logout yet in the menu app with the verification true or log out without verification because we came to that screen and rollback or the internet diconnect and cause and exeception
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? excption;
  const AuthStateLoggedOut(
      {required this.excption, required bool isLoading, String? loadingText})
      : super(isLoading: isLoading, loadingText: loadingText);
  //child states of the father state
  @override
  List<Object?> get props => [excption, isLoading];
}

//state to register -> if we cannot register forn an exception or loading the state
class AuthStateRegistering extends AuthState {
  final Exception? excption;
  const AuthStateRegistering({required bool isLoading, required this.excption})
      : super(isLoading: isLoading);
}

//state forgot password -> exception that is not a correct email , hassentemail that the user press or dont press yet the button
//privates functionalities to that state , and is loading
class AuthStateorgotPasseord extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateorgotPasseord(
      {required this.exception,
      required this.hasSentEmail,
      required bool isLoading})
      : super(isLoading: isLoading);
}
