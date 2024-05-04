part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class LoginLoading extends AuthState {}
final class LoginSuccess extends AuthState {}
final class LoginFailuer extends AuthState {
  String errMessage;

  LoginFailuer(this.errMessage);
}
final class RegisterLoading extends AuthState {}
final class RegisterSuccess extends AuthState {}
final class RegisterFailuer extends AuthState {
  String errMessage;

  RegisterFailuer(this.errMessage);
}
