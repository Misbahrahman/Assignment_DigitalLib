import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_lib/Components.dart';

final _firestore = FirebaseFirestore.instance;

dynamic stream_value = _firestore.collection('Books');

class Library_screen extends StatefulWidget {
  @override
  State<Library_screen> createState() => _Library_screenState();
}

class _Library_screenState extends State<Library_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PopupMenuButton(
                      child: Icon(Icons.sort),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('ALPHABETICAL'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection('Books')
                                    .orderBy('Title');
                                setState(() {});
                              },
                            ),
                            PopupMenuItem(
                              child: Text('YEAR PUBLISHED'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection('Books')
                                    .orderBy('Published_year');
                                setState(() {});
                              },
                            ),
                          ]),
                  SizedBox(
                    width: 20,
                  ),
                  PopupMenuButton(
                      //todo add filter algo
                      child: Icon(Icons.filter_alt_outlined),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('SELF-HELP'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection("Books")
                                    .where('Genre', isEqualTo: 'Self Help');
                                setState(() {});
                              },
                            ),
                            PopupMenuItem(
                              child: Text('FICTION'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection("Books")
                                    .where('Genre', isEqualTo: 'Fiction');
                                setState(() {});
                              },
                            ),
                            PopupMenuItem(
                              child: Text('AUTO BIOGRAPHY'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection("Books")
                                    .where('Genre', isEqualTo: 'Autobiography');
                                setState(() {});
                              },
                            ),
                            PopupMenuItem(
                              child: Text('OTHER'),
                              onTap: () {
                                stream_value = _firestore
                                    .collection("Books")
                                    .where('Genre', whereNotIn: [
                                  'Self Help',
                                  'Fiction',
                                  'Autobiography'
                                ]);
                                setState(() {});
                              },
                            )
                          ]),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    child: Icon(Icons.add),
                    //route to upload page
                    onTap: () {
                      Navigator.pushNamed(context, 'Upload_lib_screen');
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Library',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
          ),
          Book_view(),
        ],
      ),
    );
  }
}

class Book_view extends StatelessWidget {
  const Book_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream_value.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {

                  return Book_tile(
                    Title: snapshot.data!.docs[index]['Title'].toString(),
                    Author: snapshot.data!.docs[index]['Author'].toString(),
                    Cover_url: snapshot.data!.docs[index]['url'].toString(),
                    GENRE: snapshot.data!.docs[index]['Genre'].toString(),
                    snapshot: snapshot.data!.docs[index],
                  );
                }),
          );
        }
      },
    );
  }
}
