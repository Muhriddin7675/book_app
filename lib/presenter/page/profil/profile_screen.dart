import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firabase_book_app/util/component/my_text.dart';
import 'package:flutter_firabase_book_app/util/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const SizedBox(width: 20),
        backgroundColor: redColor,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          InkWell(
              borderRadius: BorderRadius.circular(11),
              onTap: () {},
              child: Image.asset(
                'assets/edit.png',
                width: 22,
                height: 22,
              )),
          const SizedBox(width: 16)
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF26B6C),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(36.0),
                        bottomLeft: Radius.circular(36.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/person.jpg',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: MyText.textBold(text: "Muhriddin", color: Colors.white, size: 24),
                      )
                    ],
                  ))),
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    rowText(title: "Ismingiz", endName: "Muhriddin"),
                    rowText(title: "Elektron pochta", endName: "muhriddin@gmail.com"),
                    rowTextEndIcon(
                        title: "Qorong'i rejimni yoqing",
                        icon: Switch(
                            value: true,
                            inactiveThumbColor: Colors.black38,
                            inactiveTrackColor: Colors.black12,
                            activeColor: redColor,
                            onChanged: (value) {}))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget rowText({required String title, required String endName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(children: [
        MyText.textBold(text: title, color: redColor, size: 18),
        const Spacer(),
        Text(
          endName,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 16),
        ),
      ]),
    );
  }

  Widget rowTextEndIcon({required String title, required Widget icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [MyText.textBold(text: title, color: redColor, size: 18), const Spacer(), icon]),
    );
  }
}
