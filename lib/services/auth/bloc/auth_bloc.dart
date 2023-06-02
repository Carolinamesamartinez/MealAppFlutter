import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealappflutter/services/auth/auth_provider.dart';
import 'package:mealappflutter/services/auth/bloc/auth_event.dart';
import 'package:mealappflutter/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //authbloc connects states of the app with events ofthe user and the logic is given bu authprovider
  AuthBloc(AuthProvider provider)
      //we have an event -> that emit an state
      //wthen the authbloc is called we initialize the state to loading
      : super(const AuthStateUnitialized(isLoading: true)) {
    //only send a email verification we dont do anything to the screen
    //when we press the eventsenemail we emit that state and send the email because of the provider
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      },
    );
    //when we call the event should register
    //we emit the state registering (we are in the screen register and we dont press any button and dont cause any exception)
    on<AuthEventShouldRegsiter>(
      (event, emit) {
        emit(const AuthStateRegistering(isLoading: false, excption: null));
      },
    );
    //when we call event forgot password first we emit fisrt the screen forgot password that si not sending a email
    on<AuthEventForgotPassword>(
      (event, emit) async {
        emit(const AuthStateorgotPasseord(
            exception: null, hasSentEmail: false, isLoading: false));
        final email = event.email;
        if (email == null) {
          return;
        } //user just want to go to forgotpassword screen
        emit(const AuthStateorgotPasseord(
            exception: null,
            hasSentEmail: false,
            isLoading:
                true)); //user wants to actuallly send a forgot password email
        //isloading to press the button

        bool didSendEmail;
        Exception? exception;
        try {
          //if not have any exception ,example -> email not correct or not user
          // we send the email and not have a exception
          await provider.sendPasswordReset(toEmail: email);
          didSendEmail = true;
          exception = null;
        } on Exception catch (e) {
          //but if we have an exception we dont send the email
          didSendEmail = false;
          exception = e;
        }
        // and we emit the result buy the variables created before but is end the state
        emit(AuthStateorgotPasseord(
            exception: exception,
            hasSentEmail: didSendEmail,
            isLoading: false));
      },
    );
    // register event -> the event give the email and password
    // and we do the action with the provider
    // and we craete the user and do sendemailveriication and emit the state that needsverification that user that is created
    //but if the user is wrong we emit that is registering
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(email: email, password: password);
          await provider.sendEmailVerification();
          emit(const AuthStateNeedsVerification(isLoading: false));
        } on Exception catch (e) {
          emit(AuthStateRegistering(excption: e, isLoading: false));
        }
      },
    );

    //we initialize de app with an user
    on<AuthEventInitialize>(((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        // if we dont have an user
        //default state we dont do anything worog and we aren not loading anything
        emit(const AuthStateLoggedOut(excption: null, isLoading: false));
      } else if (!user.isemailVerified) {
        // if the user is not verified
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        //is the user is verified
        emit(AuthStateLOgin(user: user, isLoading: false));
      }
    }));
    //we tried to login,we are loading with an loading text(press the log in button)
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(
          excption: null,
          isLoading: true,
          loadingText: 'please wait while i log you in'));
      final email = event.email;
      final password = event.password;
      try {
        // we login the user caught in the event
        final user = await provider.logIn(email: email, password: password);
        if (!user.isemailVerified) {
          //if the user is not verifies and tried to login we logout it and emit needsverificitaion with that view
          emit(const AuthStateLoggedOut(excption: null, isLoading: false));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          // we emit the login event
          // we take out os this state to bring it another time the right way
          emit(const AuthStateLoggedOut(excption: null, isLoading: false));
          emit(AuthStateLOgin(user: user, isLoading: false));
        }
      } on Exception catch (e) {
        //if we cause any exception to login we logout
        emit(AuthStateLoggedOut(excption: e, isLoading: false));
      }
    });
    //we logout with the provider if not we emit an exception
    on<AuthEventLogOut>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(excption: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(excption: e, isLoading: false));
      }
    });
  }
}
