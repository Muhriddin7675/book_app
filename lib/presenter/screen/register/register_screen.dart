import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firabase_book_app/presenter/screen/main/bottom_navigation.dart';
import 'package:flutter_firabase_book_app/presenter/screen/register/register_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../util/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  var obscureText1 = true;
  var obscureText2 = true;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterInitial) {
            if (state.hasRegister && state.message.isEmpty) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomNavigation()),
                (Route<dynamic> route) => false,
              );
            } else if (!state.hasRegister && state.message.isNotEmpty) {
              Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {}
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 56, bottom: 36),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image_group_bg.png"), fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              "assets/ic_group.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Akkaunt yarating",
                            style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Davom etish uchun roʻyxatdan oʻting",
                            style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodySmall?.color),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: _controllerEmail,
                        onChanged: (value) => _handleTextChanged(),
                        cursorColor: const Color(0xffe95757),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: redColor, width: 1.0),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              _controllerEmail.text = '';
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Email Address',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerPassword,
                        onChanged: (value) => _handleTextChanged(),
                        obscureText: obscureText1,
                        cursorColor: const Color(0xffe95757),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: redColor, width: 1.0),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText1 = !obscureText1;
                              });
                            },
                            child: Icon(
                              obscureText1 ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerConfirmPassword,
                        onChanged: (value) => _handleTextChanged(),
                        obscureText: obscureText2,
                        cursorColor: const Color(0xffe95757),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: redColor, width: 1.0),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText2 = !obscureText2;
                              });
                            },
                            child: Icon(
                              obscureText2 ? Icons.visibility_off : Icons.visibility,
                              color: const Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Retype password',
                        ),
                      ),
                      const SizedBox(height: 48),
                      InkWell(
                        onTap: () {
                          // Define your onPressed action here
                          if (_controllerPassword.text.length >= 8 &&
                              _controllerConfirmPassword.text == _controllerPassword.text &&
                              _controllerEmail.text.endsWith("@gmail.com")) {
                            context.read<RegisterBloc>().add(RegisterUserEmailInPassword(_controllerEmail.text, _controllerPassword.text));
                          } else if (_controllerPassword.text.length < 8) {
                            Fluttertoast.showToast(
                                msg: "Password 8 ta raqamdan iborat bo'lishi kerak!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (_controllerConfirmPassword.text == _controllerPassword.text) {
                            Fluttertoast.showToast(
                                msg: "Pasworda va qayta kirtilgan pasword teng emas!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (!_controllerEmail.text.endsWith("@gmail.com")) {
                            Fluttertoast.showToast(
                                msg: "Email xato kiritildi!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: redColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Ro'yxatdan o'tish",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "yoki ro'yxatdan o'ting",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 38,
                                width: 38,
                                child: Image.asset("assets/ic_google.png"),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              SizedBox(
                                height: 39,
                                width: 39,
                                child: Image.asset("assets/ic_facebook.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hisobingiz bormi ? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              " Kirish",
                              style: TextStyle(fontSize: 14, color: redColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
