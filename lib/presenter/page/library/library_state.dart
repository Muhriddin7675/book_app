part of 'library_bloc.dart';

class LibraryState {
  final Map<String, List<BookData>>? mapList;
  final Status? status;
  final String? errorMessage;

  LibraryState({this.mapList, this.status, this.errorMessage});

  LibraryState copyWith({
    final Map<String, List<BookData>>? mapList,
    final Status? status,
    final String? errorMessage,
  }) =>
      LibraryState(mapList: mapList ?? mapList, status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);
}
