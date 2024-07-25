part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {}

class LibraryLoadedEvent extends LibraryEvent{}
