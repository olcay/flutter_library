import 'package:flutter/material.dart';
import 'package:kutuphane/shelf.dart';

import 'book_card.dart';

class BookList extends StatefulWidget {
  final Shelf shelf;

  BookList({ this.shelf });

  @override
  _BookListState createState() => _BookListState(shelf: shelf);
}

class _BookListState extends State<BookList> {
  final Shelf shelf;

  _BookListState({ this.shelf });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf.title),
      ),
      body: ListView(
        children: shelf.books.map((book) => BookCard(
            book: book,
            delete: () {
              setState(() {
                shelf.books.remove(book);
              });
            },
        )).toList(),
      ),
    );
  }
}