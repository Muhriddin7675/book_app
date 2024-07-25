import 'package:bloc/bloc.dart';
import 'package:flutter_firabase_book_app/util/utils.dart';
import 'package:meta/meta.dart';

import '../../../data/model/book_data.dart';

part 'all_event.dart';

part 'all_state.dart';

class AllBloc extends Bloc<AllEvent, AllState> {
  AllBloc() : super(AllState(status: Status.LOADING)) {
    on<AllLoadEvent>((event, emit) {
      emit(state.copyWith(status: Status.SUCCESS, allList: event.listBook));
    });
  }
}
