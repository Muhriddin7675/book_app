import 'package:flutter/material.dart';
import 'package:flutter_firabase_book_app/data/model/book_data.dart';
import 'package:flutter_firabase_book_app/presenter/screen/now_playing/now_playing_screen.dart';

class BookItem extends StatelessWidget {
  final List<BookData> book;
  final int index;
  final String tag;
  final VoidCallback? clickItem;

  const BookItem({super.key, required this.book, required this.tag, required this.index, this.clickItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clickItem;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NowPlayingScreen(
                      tag: tag,
                      bookList: book,
                      index: index,
                    )));
      },
      borderRadius: BorderRadius.circular(5),
      child: Hero(
        tag: '${book[index]?.name}$tag',
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width / 3 - 28,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                book[index].image ?? '',
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(4, 4),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
