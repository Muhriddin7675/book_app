part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<BookData> books;

  SearchLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}
