part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {
  final bool hasSignIn;
  final String message;

  LoginInitial(this.hasSignIn, this.message);
}
