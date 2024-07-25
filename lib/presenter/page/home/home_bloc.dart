import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/book_data.dart';
import '../../../domain/impl/repository_book.dart';
import '../../../util/utils.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _bookRepository = RepositoryBook();
  List<String> listCategory = [];
  List<BookData> books = [];

  HomeBloc() : super(HomeState()) {
    on<Init>((event, emit) async {
      try {
        emit(state.copyWith(status: Status.LOADING, byCategoryBookStatus: Status.LOADING));
        var mapLIst = await _bookRepository.getBooksByCategory();
        books = await _bookRepository.getBooks();
        listCategory = mapLIst.keys.toList();
        listCategory = ["Hammasi", ...listCategory];
        emit(state.copyWith(category: listCategory,
            books: books,
            allBooks: books,
            status: Status.SUCCESS,
            categoryIndex: event.categoryIndex));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
    on<ByCategoryBookEvent>((event, emit) async {
      emit(state.copyWith(byCategoryBookStatus: Status.LOADING));

      if (event.categoryIndex == 0) {
        emit(state.copyWith(books: books, allBooks: books, byCategoryBookStatus: Status.SUCCESS, categoryIndex: event.categoryIndex));
      } else {
        final booksMap = await _bookRepository.getBooksByCategory();

        final byCategoryBooks = booksMap[listCategory[event.categoryIndex]];
        emit(state.copyWith(allBooks: books, books: byCategoryBooks, byCategoryBookStatus: Status.SUCCESS, categoryIndex: event.categoryIndex));
      }
    });
  }
}
