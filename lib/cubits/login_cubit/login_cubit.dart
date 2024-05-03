
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
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
}
