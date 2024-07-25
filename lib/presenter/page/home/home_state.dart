part of 'home_bloc.dart';

class HomeState {
  final List<BookData>? books;
  final List<BookData>? allBooks;
  final List<String>? category;
  final int? categoryIndex;
  final Status? status;
  final Status? byCategoryBookStatus;

  HomeState({this.categoryIndex, this.byCategoryBookStatus, this.category, this.books, this.allBooks, this.status});

  HomeState copyWith(
          {int? categoryIndex,
          List<BookData>? books,
          List<BookData>? allBooks,
          Status? status,
          List<String>? category,
          Status? byCategoryBookStatus}) =>
      HomeState(
          categoryIndex: categoryIndex ?? this.categoryIndex,
          allBooks: allBooks ?? this.allBooks,
          books: books ?? this.books,
          status: status ?? this.status,
          category: category ?? this.category,
          byCategoryBookStatus: byCategoryBookStatus ?? this.byCategoryBookStatus);
}
