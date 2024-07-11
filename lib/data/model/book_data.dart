class BookData {
  String id;
  String audio;
  String author;
  String category;
  String image;
  String name;
  String pdf;

  BookData(
      {required this.id,
      required this.audio,
      required this.author,
      required this.category,
      required this.image,
      required this.name,
      required this.pdf});

  factory BookData.fromFireStore(
      Map<String, dynamic> fireStoreData, String id) {
    return BookData(
      id: id,
      audio: fireStoreData['audio'] ?? '',
      author: fireStoreData['author'] ?? '',
      category: fireStoreData['category'] ?? '',
      image: fireStoreData['image'] ?? '',
      name: fireStoreData['name'] ?? '',
      pdf: fireStoreData['pdf'] ?? '',
    );
  }
}
