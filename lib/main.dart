import 'package:book_lib/Screens/Book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/library_screen.dart';
import 'Screens/upload_lib_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Splash_screen',
      routes: {
        'Library_screen' : (context) => Library_screen(),
        'Splash_screen' : (context) => Splash_screen(),
        'Upload_lib_screen' : (context) => Upload_lib_screen(),
        'Book_detail_screen' : (context) => Book_detail_screen()
      },
    );
  }
}
