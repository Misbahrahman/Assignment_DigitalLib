import 'package:book_lib/Screens/Book_detail_screen.dart';
import 'package:flutter/material.dart';

class Book_tile extends StatelessWidget {
  String? Title;
  String? Author;
  String? Cover_url;
  String? GENRE;
  dynamic? snapshot;

  Book_tile(
      {this.Author, this.Title, this.Cover_url, this.GENRE, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Book_detail_screen(
                    Title: Title,
                    snapshot: snapshot,
                  )),
        );
      },
      child: Container(
        //height: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                '$Cover_url',
                height: 150,
                width: 100,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$Title',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$Author',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '$GENRE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      color: Colors.orange,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);
