part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEmailInPassword extends RegisterEvent {
  final String email;
  final String password;

  const RegisterUserEmailInPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
