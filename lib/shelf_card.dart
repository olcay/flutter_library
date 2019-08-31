import 'package:flutter/material.dart';
import 'shelf.dart';

class ShelfCard extends StatelessWidget {

  final Shelf shelf;
  final Function delete;
  final Function detail;

  ShelfCard({ this.shelf, this.delete, this.detail });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: detail,
        child: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                shelf.title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                shelf.description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8.0),
              IconButton(
                onPressed: delete,
                icon: Icon(Icons.delete),
              ),

            ],
          ),
        )
        )
    );
  }
}