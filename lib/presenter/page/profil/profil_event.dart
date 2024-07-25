part of 'profil_bloc.dart';

@immutable
sealed class ProfilEvent {}

class ProfilImageSelected extends ProfilEvent {
  final XFile image;

  ProfilImageSelected({required this.image});
}
