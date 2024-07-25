import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc() : super(ProfilState()) {
    on<ProfilEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
