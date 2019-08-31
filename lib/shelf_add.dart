import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane/shelf.dart';

class ShelfAdd extends StatefulWidget {
  final List<Shelf> shelves;

  ShelfAdd({this.shelves});

  @override
  _ShelfAddState createState() => _ShelfAddState(shelves: shelves);
}

// Create a corresponding State class.
// This class holds data related to the form.
class _ShelfAddState extends State<ShelfAdd> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final List<Shelf> shelves;

  _ShelfAddState({this.shelves});

  final titleFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('New shelf'),
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
                decoration: InputDecoration(labelText: 'Description'),
                controller: descriptionFieldController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    //Scaffold.of(context)
                    //    .showSnackBar(SnackBar(content: Text('Processing Data')));

                    setState(() {
                      shelves.add(Shelf(
                          title: titleFieldController.text,
                          description: descriptionFieldController.text,
                          books: []));
                    });

                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
