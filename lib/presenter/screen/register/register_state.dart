part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {
  final bool hasRegister;
  final String message;

  RegisterInitial(this.hasRegister, this.message);
}
