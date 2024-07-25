part of 'search_bloc.dart';

class SearchState {
  final List<BookData>? books;
  final Status? status;
  final String? errorMessage;

  SearchState({this.books, this.status, this.errorMessage});

  SearchState copyWith({
    final List<BookData>? books,
    final Status? status,
    final String? errorMessage,
  }) =>
      SearchState(books: books ?? this.books, status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);
}
