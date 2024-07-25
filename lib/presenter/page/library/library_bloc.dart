import 'package:bloc/bloc.dart';
import 'package:flutter_firabase_book_app/domain/impl/repository_book.dart';
import 'package:flutter_firabase_book_app/util/utils.dart';
import 'package:meta/meta.dart';

import '../../../data/model/book_data.dart';

part 'library_event.dart';

part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryState()) {
    on<LibraryLoadedEvent>((event, emit) async {
      emit(state.copyWith(status: Status.LOADING));
      try {
        var repository = RepositoryBook();
        var mapList = await repository.getBooksByCategory();
        emit(state.copyWith(status: Status.SUCCESS, mapList: mapList));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR, errorMessage: e.toString()));
      }
    });
  }
}
