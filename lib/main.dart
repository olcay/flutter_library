import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kutuphane/book_list.dart';
import 'package:kutuphane/shelf_add.dart';
import 'package:kutuphane/shelf_edit.dart';
import 'book.dart';
import 'shelf.dart';
import 'shelf_card.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: ShelfList()));

class ShelfList extends StatefulWidget {
  @override
  _ShelfListState createState() => _ShelfListState();
}

Future<List<Shelf>> fetchAlbum() async {
  final response = await http
      .get('https://otomatikmuhendis-staging.herokuapp.com/api/shelves');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> list = json.decode(response.body);

    return list.map((s) => Shelf.fromJson(s)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _ShelfListState extends State<ShelfList> {
  List<Shelf> shelves = [
    Shelf(
        title: 'Discworld Series',
        description: 'Terry Pratchett`e saygiyla',
        books: [
          Book(title: "The Colour Of Magic", author: "Terry Pratchett"),
          Book(title: "Mort", author: "Terry Prachet"),
          Book(title: "Equal Rites", author: "Terry Prachet"),
          Book(title: "The Light Fantastic", author: "Terry Prachet"),
        ]),
    Shelf(title: 'Çilek Kitaplığı', description: 'Dev arsiv', books: []),
    Shelf(title: 'Español', description: 'Ispanyolca kitaplar', books: [])
  ];

  Future<List<Shelf>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Shelves'),
        centerTitle: true,
        backgroundColor: Colors.orange[600],
      ),
      body: Center(
        child: FutureBuilder<List<Shelf>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data
                    .map((shelf) => ShelfCard(
                        shelf: shelf,
                        detail: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookList(shelf: shelf)),
                          );

                          if (result == "Delete") {
                            setState(() {
                              shelves.remove(shelf);
                            });

                            final snackBar = SnackBar(
                              content: Text(shelf.title + ' is removed!'),
                              action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                    setState(() {
                                      shelves.add(shelf);
                                    });
                                  }),
                            );

                            // Find the Scaffold in the widget tree and use
                            // it to show a SnackBar.
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else if (result == "Edit") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShelfEdit(shelf: shelf)),
                            );
                          }
                        }))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[600],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShelfAdd(shelves: shelves)),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.orange[600],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Close'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
