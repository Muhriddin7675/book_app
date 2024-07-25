part of 'all_bloc.dart';

class AllState {
  final List<BookData>? allList;
  final Status status;

  AllState({ this.allList, required this.status});

  AllState copyWith({
    final List<BookData>? allList,
    final Status? status,
  }) =>
      AllState(allList: allList ?? this.allList, status: status ?? this.status);
}
