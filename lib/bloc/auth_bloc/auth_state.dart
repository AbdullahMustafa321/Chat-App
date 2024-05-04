part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}
final class LoginLoadingState extends AuthState {}
final class LoginSuccessState extends AuthState {}
final class LoginFailuerState extends AuthState {
  String errMessage;

  LoginFailuerState(this.errMessage);
}
final class RegisterLoadingState extends AuthState {}
final class RegisterSuccessState extends AuthState {}
final class RegisterFailuerState extends AuthState {
  String errMessage;

  RegisterFailuerState(this.errMessage);
}
