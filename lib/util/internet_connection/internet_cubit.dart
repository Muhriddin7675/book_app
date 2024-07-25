import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/internet_state.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/internet_type.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _connectivityStream;

  InternetCubit({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(InternetState(type: InternetType.unknown)) {
    _connectivityStream = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)) {
        emit(InternetState(type: InternetType.connected));
      } else if (results.contains(ConnectivityResult.none)) {
        emit(InternetState(type: InternetType.offline));
      } else {
        emit(InternetState(type: InternetType.unknown));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStream.cancel();
    return super.close();
  }
}
