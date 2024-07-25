import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/screen/splash/splash_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/screen/splash/splash_screen.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/internet_cubit.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/internet_state.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/internet_type.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/loading.dart';
import 'package:flutter_firabase_book_app/util/internet_connection/no_internet.dart';
import 'package:flutter_firabase_book_app/util/theme/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'data/pref/my_shared.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await MyShared.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Future.delayed(const Duration (seconds: 5));
  FlutterNativeSplash.remove();

  runApp(BlocProvider(
    create: (_) => InternetCubit(connectivity: Connectivity()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            late final Widget page;
            if (state.type == InternetType.offline) {
              page = const NoInternet();
            } else if (state.type == InternetType.connected) {
              page = BlocProvider(
                create: (context) => SplashBloc(),
                child: const SplashScreen(),
              );
            } else {
              page = const Loading();
            }
            kNavigatorKey.currentState!.push(
                MaterialPageRoute(builder: (_) => page));
          },
          child: child,
        );
      },
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}
