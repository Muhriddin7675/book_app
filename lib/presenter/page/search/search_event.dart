part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchCursorEvent extends SearchEvent {
  final String cursor;

  SearchCursorEvent({required this.cursor});
}
