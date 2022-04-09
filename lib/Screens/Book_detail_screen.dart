import 'package:flutter/material.dart';

class Book_detail_screen extends StatelessWidget {
  String? Title;
  dynamic? snapshot;
  Book_detail_screen({@required this.Title, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.network(
                    '${snapshot['url'].toString()}',
                    height: 400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${snapshot['Title'].toString()}',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${snapshot['Genre'].toString()}',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'SUMMARY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${snapshot['Description'].toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
