import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginUser({required String email,required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'invalid-credential') {
        emit(LoginFailuer('Invalid email or password!'));
      }
    }
    catch (e) {
      emit(LoginFailuer('Something went wrong'));
    }
  }
  Future<void> registerUser({required String email,required String password}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailuer('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailuer('The account already exists for that email.'));
      }
    }
    catch (e) {
      emit(RegisterFailuer('There was an error'));
    }
  }
}
