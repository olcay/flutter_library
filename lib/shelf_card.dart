import 'package:flutter/material.dart';
import 'shelf.dart';
import 'package:jiffy/jiffy.dart';

class ShelfCard extends StatelessWidget {
  final Shelf shelf;
  final Function delete;
  final Function detail;

  ShelfCard({this.shelf, this.delete, this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: ListTile(
          onTap: detail,
          title: Text(shelf.title),
          subtitle: Text("Last updated " + Jiffy(shelf.updateDate).fromNow()),
          trailing: Icon(Icons.keyboard_arrow_right),
        ));
  }
}
