part of 'all_bloc.dart';

@immutable
sealed class AllEvent {}

class AllLoadEvent extends AllEvent {
  final List<BookData> listBook;

  AllLoadEvent({required this.listBook});
}
