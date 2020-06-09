import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sport_trivia_app/views/quiz_play.dart';

class Result extends StatefulWidget {
  int score, totalQuestion, correct, incorrect, notAttempted;

  Result(
      {this.score,
        this.totalQuestion,
        this.correct,
        this.incorrect,
        this.notAttempted});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String greeting = "";
  @override
  void initState() {
    super.initState();

    var percentage = (widget.score / (widget.totalQuestion * 20)) * 100;
    if (percentage >= 90) {
      greeting = "Outstanding";
    } else if (percentage > 80 && percentage < 90) {
      greeting = "Good Work";
    } else if (percentage > 70 && percentage < 80) {
      greeting = "Good Work";
    } else if (percentage < 70) {
      greeting = "Good Work";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$greeting", style: TextStyle( fontSize: 24, fontWeight: FontWeight.w500),),
              SizedBox(height: 14,),
              Text(
                  "You Scored ${widget.score} out of ${widget.totalQuestion * 20}"),
              Text(
                "${widget.correct} Correct, ${widget.incorrect} incorrect &  ${widget.notAttempted} out of ${widget.totalQuestion} not attempted", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400 ),),
              SizedBox(height: 16,),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPlay(),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                      "Replay Quiz Now",
                      style: TextStyle(color: Colors.white, fontSize: 18)
                  ),
                ),
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPlay(),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.blue, width: 2)
                  ),
                  child: Text(
                    "Go to home",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  Share.share("I scored ${widget.score} over ${widget.totalQuestion * 20} in the fun Sports Trivia App,\n Think you can do better, Join me ");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.blue, width: 2)
                  ),
                  child: Text(
                    "Share your Score",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void share(BuildContext context, $, Set<int> set) {}
}
