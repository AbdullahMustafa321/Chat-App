import 'package:chat_app/cubits/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
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
