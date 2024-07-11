import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/screen/splash/splash_bloc.dart';
import '../main/main.dart';
import '../register/register_bloc.dart';
import '../register/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const Main()),
            (Route<dynamic> route) => false,
          );
        } else if (state is Unauthenticated) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => RegisterBloc(),
                        child: const RegisterScreen(),
                      ))
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/image_group_bg.png"))),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Image.asset(
                        "assets/image_group.png",
                      ),
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.7, // 70% shaffoflik
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                Colors.white54, // Luminosity uchun asosiy rang
                                BlendMode.luminosity, // BlendMode turi
                              ),
                              child: Image.asset(
                                'assets/image_book_splash.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 214,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 32.0, right: 24),
                            child: InkWell(
                              onTap: () {
                                print("CheckAuthEvent yuborilmoqda");
                                context
                                    .read<SplashBloc>()
                                    .add(CheckAuthEvent());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: const Color(0xffF26B6C)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Get Started ",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
