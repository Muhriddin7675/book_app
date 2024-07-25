import 'package:flutter/material.dart';
import 'package:flutter_firabase_book_app/util/component/my_text.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/no_connection.png", height: width, width: width),
            const SizedBox(height: 24),
            MyText.textBold(text: "Sizda internet mavjud emas!",
                color: Theme.of(context).textTheme.bodyMedium?.color,
                size: 18)

          ],
        ),
      ),
    );
  }
}
