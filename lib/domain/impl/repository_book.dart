import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/book_data.dart';

class RepositoryBook {

  Future<List<BookData>> getBooks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('books').get();

    return snapshot.docs.map((doc) {
      return BookData.fromFireStore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<Map<String, List<BookData>>> getBooksByCategory() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('books').get();

    List<BookData> books = snapshot.docs.map((doc) {
      return BookData.fromFireStore(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    Map<String, List<BookData>> booksByCategory = {};

    for (BookData book in books) {
      if (!booksByCategory.containsKey(book.category)) {
        booksByCategory[book.category] = [];
      }
      booksByCategory[book.category]!.add(book);
    }
    return booksByCategory;
  }
}
