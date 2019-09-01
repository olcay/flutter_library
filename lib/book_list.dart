import 'package:flutter/material.dart';
import 'package:kutuphane/shelf.dart';

import 'book_add.dart';
import 'book_card.dart';

class BookList extends StatefulWidget {
  final Shelf shelf;

  BookList({this.shelf});

  @override
  _BookListState createState() => _BookListState(shelf: shelf);
}

class _BookListState extends State<BookList> {
  final Shelf shelf;

  _BookListState({this.shelf});

  void _select(Choice choice) {
      Navigator.pop(context, choice.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf.title),
        backgroundColor: Colors.red[600],
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: shelf.books
            .map((book) => BookCard(
                  book: book,
                  delete: () {
                    setState(() {
                      shelf.books.remove(book);
                    });
                  },
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[600],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookAdd(shelf: shelf)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Edit'),
  const Choice(title: 'Delete'),
];