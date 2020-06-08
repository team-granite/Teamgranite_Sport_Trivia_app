import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_trivia_app/data/data.dart';
import 'package:sport_trivia_app/model/questionModel.dart';
import 'package:sport_trivia_app/views/score.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  List<QuestionModel> _questions = List<QuestionModel>();
  int index = 0;
  int correct = 0, incorrect = 0, notAttempted = 0, points = 0;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();
    _questions = getQuestion();

    animationController =
        AnimationController(duration: const Duration(seconds: 15), vsync: this)
          ..addListener(() {
            setState(() {});
          });

    animation =
        Tween(begin: beginAnim, end: endAnim).animate(animationController);

    startAnim();

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (index < _questions.length - 1) {
          index++;
          resetAnim();
          startAnim();
          notAttempted++;
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Result(
                  score: points,
                  totalQuestion: _questions.length,
                  correct: correct,
                  incorrect: incorrect,
                  notAttempted: notAttempted,

                ),
              ));
        }
      }
    });
  }

  resetAnim() {
    animationController.reset();
  }

  stopAnim() {
    animationController.stop();
  }

  startAnim() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${index + 1}/${_questions.length}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Question",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                        Spacer(),
                        Text("$points",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Points",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                      ]),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("${_questions[index].getQuestion()}?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
                SizedBox(
                  height: 20,
                ),
                LinearProgressIndicator(
                  value: animation.value,
                ),
                CachedNetworkImage(
                  imageUrl: _questions[index].getImageUrl(),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              if (_questions[index].getAnswer() == "True") {
                                setState(() {
                                  points += 20;
                                });
                                index++;
                                correct++;
                                resetAnim();
                                startAnim();

                              } else {
                                points -= 5;
                                index++;
                                incorrect++;

                                resetAnim();
                                startAnim();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              child: Text(
                                "True",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.blue),
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (_questions[index].getAnswer() == "False") {
                              setState(() {
                                points += 20;
                              });
                              index++;
                              correct++;

                              resetAnim();
                              startAnim();
                            } else {
                              points -= 5;
                              index++;
                              incorrect++;

                              resetAnim();
                              startAnim();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: Text(
                              "False",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
