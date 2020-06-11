import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sport_trivia_app/model/questionModel.dart';
import 'package:sport_trivia_app/views/score.dart';
import 'package:quiver/async.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  static const String url = "https://opentdb.com/api.php?amount=10&category=21&type=boolean";
  int countDownToZero = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int totalTime = 15;
  bool isNetworkTimeOut = false;

  List<Results> _questions = [];
  var loading = false;

  void startCountDownTimer() {
    CountdownTimer timer = CountdownTimer(Duration(seconds: totalTime), Duration(seconds: 1),);
    var subscription = timer.listen(null);
    subscription.onData((data) {
      setState(() {
        countDownToZero = totalTime - data.elapsed.inSeconds;
      });
    });
    subscription.onDone(() {
      if (_questions.isEmpty) {
        setState(() {
          isNetworkTimeOut = true;
        });
      }
      subscription.cancel();
    });
  }


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
        isNetworkTimeOut = false;
      });
      startAnim();
    }
    else{
      setState(() {
        isNetworkTimeOut = true;
      });
    }
  }

  int index = 0;
  int correct = 0,
      incorrect = 0,
      notAttempted = 0,
      points = 0;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    startCountDownTimer();
    animationController = AnimationController(duration: const Duration(seconds: 7), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    animation = Tween(begin: beginAnim, end: endAnim).animate(animationController);

    // startAnim();

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
          notAttempted++;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Result(
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
          builder: (context) =>
              Result(
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: 'Sports',
              style: TextStyle(color: Colors.white70, fontSize: 25.0),
              children: <TextSpan>[
                TextSpan(text: 'Trivia', style: TextStyle(color: Colors.deepOrange, fontSize: 25.0))
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xff071a35),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff071a35),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 2.0, // has the effect of softening the shadow
                spreadRadius: 2.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15.0),
          child: _questions.isNotEmpty
              ?
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: (!isLastQuestion()) ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text("${index + 1}/${_questions.length}",
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Question",
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                          Spacer(),
                          Text("$points",
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Points",
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                        ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      LinearProgressIndicator(
                        value: animation.value,
                        backgroundColor: Color(0xFFFF5722),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('${getQuestion(_questions[index].question)}?',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0,
                            )),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  if (_questions[index].correct_answer == "True") {
                                    setState(() {
                                      points += 10;
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
                                      points = points - 5;
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
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "True",
                                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                                  ),
                                  decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.blue),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (_questions[index].correct_answer == "False") {
                                  setState(() {
                                    points += 10;
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
                                    points = points - 5;
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
                          ],
                        ),
                      )
                    ],
                  ) : Center(child: Text(' '),),
                ),
              ),
            );
          })
              : Center(
            child: isNetworkTimeOut ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Connection to server timed out.',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),textAlign: TextAlign.center,
                  ),
                ),
                RaisedButton(
                  child: Text('Reload'),
                  onPressed: () {
                    setState(() {
                      isNetworkTimeOut = false;
                    });
                    _fetchQuestions();
                    startCountDownTimer();
                  },
                ),
              ],
            ): Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Loading questions...',
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getQuestion(String htmlString) {
    var htmlDocument = parse(htmlString);
    String parsedString = parse(htmlDocument.body.text).documentElement.text;
    return parsedString.replaceAll('.', '');
  }
}
