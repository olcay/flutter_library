import 'book.dart';

class Shelf {
  int id;
  String title;
  String description;
  List<Book> books;
  DateTime updateDate;

  Shelf({this.id, this.title, this.description, this.books, this.updateDate});

  factory Shelf.fromJson(Map<String, dynamic> json) {
    var items = List<Book>.from(json['items'].map((b) => Book.fromJson(b)));

    return Shelf(
      id: json['id'],
      title: json['title'],
      updateDate: DateTime.parse(json['updateDate']),
      books: items
    );
  }
}
