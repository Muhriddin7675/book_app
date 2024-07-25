part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class Init extends HomeEvent {
  final int categoryIndex;

  Init({required this.categoryIndex});
}

class ByCategoryBookEvent extends HomeEvent{
  final int categoryIndex;

  ByCategoryBookEvent({required this.categoryIndex});

}