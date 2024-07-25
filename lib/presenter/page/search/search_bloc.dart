import 'package:bloc/bloc.dart';
import 'package:flutter_firabase_book_app/util/utils.dart';

import '../../../data/model/book_data.dart';
import '../../../domain/impl/repository_book.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(status: Status.LOADING)) {
    var bookRepository = RepositoryBook();
    on<SearchCursorEvent>((event, emit) async {
      emit(state.copyWith(status: Status.LOADING));

      try {
        final books = await bookRepository.getBooks();
        if (event.cursor.isNotEmpty) {
          var searchBooks = books.where((element) => element.name.toLowerCase().startsWith(event.cursor.toLowerCase())).toList();
          emit(state.copyWith(status: Status.SUCCESS, books: searchBooks));
        } else {
          emit(state.copyWith(status: Status.SUCCESS, books: books));
        }
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR, errorMessage: e.toString()));
      }
    });
  }
}
