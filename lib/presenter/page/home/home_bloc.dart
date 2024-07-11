import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/book_data.dart';
import '../../../domain/repository_book.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    var bookRepository = RepositoryBook();
    on<LoadBooks>((event, emit) async {
      emit(HomeLoading());
      if (event.category == "hammasi") {
        try {
          final books = await bookRepository.getBooks();
          emit(HomeLoaded(books, books));
        } catch (e) {
          emit(HomeError(e.toString()));
        }
      } else {
        try {
          final booksMap = await bookRepository.getBooksByCategory();
          final books = booksMap[event.category];
          final allBooks = await bookRepository.getBooks();
          if (books != null) {
            emit(HomeLoaded(books, allBooks));
          } else {
            emit(HomeError("Hali kitob qo'shilmagan!"));
          }
        } catch (e) {
          emit(HomeError(e.toString()));
        }
      }
    });
  }
}
