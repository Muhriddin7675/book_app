import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/book_data.dart';
import '../../../domain/repository_book.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    var bookRepository = RepositoryBook();

    on<SearchEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final books = await bookRepository.getBooks();
        var searchBooks = books.where((element) => element.name.toLowerCase().startsWith(event.cursor.toLowerCase()))
            .toList();

        print(searchBooks);
        print(event.cursor);

        emit(SearchLoaded(searchBooks));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
