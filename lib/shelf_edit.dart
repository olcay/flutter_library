import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane/shelf.dart';

class ShelfEdit extends StatefulWidget {
  final Shelf shelf;

  ShelfEdit({this.shelf});

  @override
  _ShelfEditState createState() => _ShelfEditState(shelf: shelf);
}

// Create a corresponding State class.
// This class holds data related to the form.
class _ShelfEditState extends State<ShelfEdit> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final Shelf shelf;

  _ShelfEditState({this.shelf});

  TextEditingController _titleFieldController;
  TextEditingController _descriptionFieldController;

  @override
  void initState() {
    super.initState();
    _titleFieldController = new TextEditingController(text: shelf.title);
    _descriptionFieldController =
        new TextEditingController(text: shelf.description);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text(shelf.title),
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
                controller: _titleFieldController,
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
                controller: _descriptionFieldController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      shelf.title = _titleFieldController.text;
                      shelf.description = _descriptionFieldController.text;
                    });

                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
