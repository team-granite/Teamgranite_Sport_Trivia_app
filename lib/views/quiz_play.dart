import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sport_trivia_app/model/questionModel.dart';
import 'package:sport_trivia_app/views/score.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  static const String url = "https://opentdb.com/api.php?amount=10&category=21&type=boolean";

  List<Results> _questions = [];
  var loading = false;

  Future<Null> _fetchQuestions() async {
    setState(() {
      loading = true;
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Results> tempList = [];
      Map<String, dynamic> data = jsonDecode(response.body);
      data['results'].forEach((item) {
        tempList.add(Results.fromJson(item));
      });

      setState(() {
        _questions = tempList;
        loading = false;
      });
    }
  }

  int index = 0;
  int correct = 0, incorrect = 0, notAttempted = 0, points = 0;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();

    animationController = AnimationController(duration: const Duration(seconds: 15), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    animation = Tween(begin: beginAnim, end: endAnim).animate(animationController);

    startAnim();

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        if (index < _questions.length - 1) {
          setState(() {
            index++;
            notAttempted++;
          });
          resetAnim();
          startAnim();
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

  bool isLastQuestion() {
    return (_questions.length == index);
  }

  void goToResult() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 80),
          child: _questions.isNotEmpty
              ? Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text("${index + 1}/${_questions.length}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Question", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                  Spacer(),
                  Text("$points", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Points", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
                ]),
              ),
              SizedBox(
                height: 40,
              ),
              if(!isLastQuestion()) Text("${_questions[index].question}?",
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
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            if (_questions[index].correct_answer == "True") {
                              setState(() {
                                points += 20;
                                correct++;
                              });
                              index++;

                              if (isLastQuestion()) {
                                stopAnim();
                                goToResult();
                              } else {
                                resetAnim();
                                startAnim();
                              }
                            } else {
                              setState(() {
                                points -= 5;
                                incorrect++;
                              });
                              index++;

                              if (isLastQuestion()) {
                                stopAnim();
                                goToResult();
                              } else {
                                resetAnim();
                                startAnim();
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: Text(
                              "True",
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.blue),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (_questions[index].correct_answer == "False") {
                            setState(() {
                              points += 20;
                              correct++;
                            });
                            index++;

                            if (isLastQuestion()) {
                              stopAnim();
                              goToResult();
                            } else {
                              resetAnim();
                              startAnim();
                            }
                          } else {
                            setState(() {
                              points -= 5;
                              incorrect++;
                            });
                            index++;

                            if (isLastQuestion()) {
                              stopAnim();
                              goToResult();
                            } else {
                              resetAnim();
                              startAnim();
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            "False",
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text('Loading questions...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
