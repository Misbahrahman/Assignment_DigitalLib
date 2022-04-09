import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

//Defined snackbar widget
showSnackBar(String snackText, Duration d, BuildContext con) {
  final snackBar = SnackBar(content: Text(snackText), duration: d);
  ScaffoldMessenger.of(con).showSnackBar(snackBar);
}

class Upload_lib_screen extends StatefulWidget {
  @override
  State<Upload_lib_screen> createState() => _Upload_lib_screenState();
}

class _Upload_lib_screenState extends State<Upload_lib_screen> {
  File? _image;
  final imagePicker = ImagePicker();
  String? url;
  String? Title_feeded;
  String? Genre_feeded;
  String? Description_feeded;
  String? Author_feeded;

  //image picker method
  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400), context);
      }
    });
  }

  //firebase upload method and feeding url in cloud firebase
  Future uploadData(
    File _image,
  ) async {
    final imgId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
        .ref()
        //.child('/images')
        .child("post_$imgId");

    await reference.putFile(_image);
    url = await reference.getDownloadURL();

    // cloud firestore
    await firebaseFirestore.collection("Books").add({
      'url': url,
      'Title': Title_feeded,
      'Genre': Genre_feeded,
      'Description': Description_feeded,
      'Author': Author_feeded
    }).whenComplete(
      () => showSnackBar("Image Uploaded", Duration(seconds: 2), context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UPLOAD BOOK INFO"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Upload Book Cover"),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // the image that we wanted to upload
                              Expanded(
                                  child: _image == null
                                      ? const Center(
                                          child: Text("No image selected"))
                                      : Image.file(_image!)),
                              ElevatedButton(
                                  onPressed: () {
                                    imagePickerMethod();
                                  },
                                  child: const Text("Select Image")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          'Title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextField(
                            onChanged: (title_entered) {
                              Title_feeded = title_entered;
                            },
                            decoration: InputDecoration(hintText: 'Title')),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          'Author',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextField(
                            onChanged: (Author_entered) {
                              Author_feeded = Author_entered;
                            },
                            decoration: InputDecoration(hintText: 'Author')),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          'Genre',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextField(
                          onChanged: (genre_entered) {
                            Genre_feeded = genre_entered;
                          },
                          decoration: InputDecoration(hintText: 'Genre'),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        TextField(
                          onChanged: (Description_entered) {
                            Description_feeded = Description_entered;
                          },
                          decoration: InputDecoration(hintText: 'Description'),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_image != null) {
                            uploadData(_image!);
                            Navigator.pop(context);
                          } else {
                            showSnackBar("Select Image first",
                                Duration(milliseconds: 400), context);
                          }
                        },
                        child: const Text(
                          "U P L O A D",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


