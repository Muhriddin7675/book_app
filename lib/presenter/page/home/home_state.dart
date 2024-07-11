part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BookData> books;
  final List<BookData> allBooks;

  HomeLoaded(this.books, this.allBooks);

  @override
  List<Object> get props => [books, allBooks];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
