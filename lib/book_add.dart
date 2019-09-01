import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/books/v1.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:kutuphane/helper/secret_loader.dart';
import 'package:kutuphane/shelf.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'book.dart';
import 'entities/secret.dart';

class BookAdd extends StatefulWidget {
  final Shelf shelf;

  BookAdd({this.shelf});

  @override
  _BookAddState createState() => _BookAddState(shelf: shelf);
}

// Create a corresponding State class.
// This class holds data related to the form.
class _BookAddState extends State<BookAdd> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final Shelf shelf;

  _BookAddState({this.shelf});

  final titleFieldController = TextEditingController();
  final authorFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('New book'),
        backgroundColor: Colors.red[600],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(labelText: "Title"),
                controller: titleFieldController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                controller: authorFieldController,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          shelf.books.add(Book(
                              title: titleFieldController.text,
                              author: authorFieldController.text));
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      Secret credentials = await SecretLoader().load();

                      final _credentials =
                          new ServiceAccountCredentials.fromJson(
                              credentials.serviceAccountCredentials);

                      const _SCOPES = const [BooksApi.BooksScope];

                      String isbn13 = await FlutterBarcodeScanner.scanBarcode(
                          "#fb8c00", "Cancel", false);

                      clientViaServiceAccount(_credentials, _SCOPES)
                          .then((httpClient) {
                        var books = new BooksApi(httpClient);
                        print("Results for $isbn13 ...");

                        books.volumes
                            .list(isbn13, printType: "books")
                            .then((volumes) {
                          titleFieldController.text =
                              volumes.items.first.volumeInfo.title;
                          authorFieldController.text =
                              volumes.items.first.volumeInfo.authors.first;

                          for (var book in volumes.items) {
                            print(book.volumeInfo.title);
                          }
                        });
                      });
                    },
                    child: Text('Scan'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
