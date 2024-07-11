import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/pref/my_shared.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAuthEvent>((event, emit){
      var myShared = MyShared();
      final isLoggedIn = myShared.getHasLogin();
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
