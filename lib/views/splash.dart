import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Color(0xff071a35),
      navigateAfterSeconds: HomePage(),
      title: Text('SportTrivia',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.red
        ),),

      image: Image.asset('image/object.png'),
      photoSize: 40.0,
      loaderColor: Colors.red,
      loadingText: Text("...", style: TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
          fontSize: 30
      ),),



    );
  }
}