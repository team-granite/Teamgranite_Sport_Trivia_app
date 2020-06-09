import 'package:flutter/material.dart';

import 'quiz_play.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff071a35),

        body: Center(
          child: InkWell(

            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>  QuizPlay()  ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical:12, horizontal:54),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text("Start Quiz",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ),
        ),
      ),
    );
  }
}