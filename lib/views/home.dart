import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sport_trivia_app/views/quiz_play.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff071a35),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset('image/object.png', fit: BoxFit.cover, height: 125,),
            SizedBox(height: 5,),
            Text(
              'SportsTrivia',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.deepOrange),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                _checkConnectivity(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  "Start Quiz",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

 _checkConnectivity(context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none){
      _displayDialog(
        context,
          Text(
              "No Connection",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  fontFamily: "fonts/BalsamiqSans-Bold.ttf"
              )
          ),
          Text(
            "Oops, You do not have internet connection. \n\nClick reload to try again",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                letterSpacing: 2.0,
                fontFamily: "fonts/BalsamiqSans-Bold.ttf"
            ),
          )
      );
    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => QuizPlay()));
    }
}

void _displayDialog(context,title,text) {
  showDialog(
      context: context,
    builder: (context){
        return AlertDialog(
          title: title,
          content: text,
          backgroundColor: Color(0xff071a35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          ),
          elevation: 1,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.deepOrange,
                ),
                label: Text("Reload")
            )
          ],
        );
    }
  );
}
