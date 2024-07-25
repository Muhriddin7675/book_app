part of 'profil_bloc.dart';

class ProfilState {
  final XFile? pickedImage;
  final String? email;
  final String? name;
  final bool? hasDarkMode;

  ProfilState({this.pickedImage, this.email, this.name, this.hasDarkMode});

  ProfilState copyWith(XFile? pickedImage, String? email, String? name, bool? hasDarkMode) => ProfilState(
      pickedImage: pickedImage ?? this.pickedImage,
      email: email ?? this.email,
      name: name ?? this.name,
      hasDarkMode: hasDarkMode ?? this.hasDarkMode);

}
