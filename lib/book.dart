class Book {
  int id;
  String title;
  String author;

  Book({this.id, this.title, this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        title: json['title'],
        author: "Author"
    );
  }
}
