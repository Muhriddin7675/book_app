part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginUserEmailInPassword extends LoginEvent {
  final String email;
  final String password;

  LoginUserEmailInPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
