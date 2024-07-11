import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/pref/my_shared.dart';
import '../../../domain/repository_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial(false,"")) {
    var auth = RepositoryAuth();
    var myShared = MyShared();
    on<RegisterUserEmailInPassword>((event, emit) async {
      var boolean = await auth.createUser(event.email, event.password);
      if( boolean){
        myShared.setHasLogin(true);
        emit(RegisterInitial(true,""));
      }else {
          emit(RegisterInitial(false,"Registiratsiya bo'lmadi!"));
        }
    });
  }
}
