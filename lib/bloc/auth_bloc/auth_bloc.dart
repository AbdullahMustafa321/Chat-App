import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(LoginSuccessState());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'invalid-credential') {
            emit(LoginFailuerState('Invalid email or password!'));
          }
        } catch (e) {
          emit(LoginFailuerState('Something went wrong'));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoadingState());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailuerState('The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailuerState(
                'The account already exists!'));
          }
        } catch (e) {
          emit(RegisterFailuerState('There was an error'));
        }
      }
    });
  }
}
