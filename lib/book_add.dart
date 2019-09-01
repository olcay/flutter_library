import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane/shelf.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'book.dart';

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
  final descriptionFieldController = TextEditingController();

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
                controller: descriptionFieldController,
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
                              author: descriptionFieldController.text));
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
                      titleFieldController.text = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false);
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
