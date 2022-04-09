import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //to delay a little bit
    Future.delayed(const Duration(seconds: 5), () {
      check_connectivity();
    });
  }

  // to check connection state
  void check_connectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Navigator.pushNamed(context, 'Library_screen');
    }
    if (connectivityResult == ConnectivityResult.wifi) {
      Navigator.pushNamed(context, 'Library_screen');
    } else {
      //Show error snackbar
      final snackBar = SnackBar(
          content: Text(
            'Check your Internet connectivity and try again',
            style: TextStyle(fontSize: 20),
          ),
          duration: Duration(minutes: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'DIGITAL LIBRARY',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 80),
            textAlign: TextAlign.center,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
