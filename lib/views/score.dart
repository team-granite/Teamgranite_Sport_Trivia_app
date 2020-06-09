import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_trivia_app/views/quiz_play.dart';

class Result extends StatefulWidget {
  int score, totalQuestion, correct, incorrect, notAttempted;

  Result({this.score, this.totalQuestion, this.correct, this.incorrect, this.notAttempted});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String greeting = "";
  double percentageInDecimal;
  String highScore = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    var percentage = (widget.score / (widget.totalQuestion * 20)) * 100;
    if (percentage >= 90) {
      greeting = "Outstanding!";
    } else if (percentage > 80 && percentage < 90) {
      greeting = "Good Work!";
    } else if (percentage > 70 && percentage < 80) {
      greeting = "Good Work!";
    } else if (percentage < 70) {
      greeting = "You can do better!";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getHighScore();
  }

  @override
  Widget build(BuildContext context) {
    percentageInDecimal = widget.score / (widget.totalQuestion * 10);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(child: Text(greeting,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),),
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width / 2,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 15.0,
                  percent: percentageInDecimal,
                  center: Text(
                    '${(percentageInDecimal * 100).floor()} %',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  linearGradient: LinearGradient(colors: [Colors.blue, Colors.orange, Colors.green]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'Your results are:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      resultSummary(
                          context: context,
                          icon: Icons.check_circle,
                          iconColor: Colors.green,
                          valueReported: widget.correct,
                          total: widget.totalQuestion,
                          category: 'Correct'),
                      VerticalDivider(
                        thickness: 1,
                      ),
                      resultSummary(
                          context: context,
                          icon: Icons.radio_button_unchecked,
                          iconColor: Colors.blue,
                          valueReported: widget.notAttempted,
                          total: widget.totalQuestion,
                          category: 'Skipped'),
                      VerticalDivider(
                        thickness: 1,
                      ),
                      resultSummary(
                          context: context,
                          icon: Icons.cancel,
                          iconColor: Colors.red,
                          valueReported: widget.incorrect,
                          total: widget.totalQuestion,
                          category: 'Wrong'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                ListTile(
                    title: Text(
                      'Share Score',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Share your result with your friends to let them know your score'),
                    trailing: Icon(
                      Icons.share,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Share.share(
                          "I scored ${widget.score} over ${widget.totalQuestion * 10} in the fun Sports Trivia App,\n Think you can do better? Join me ");
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                ListTile(
                  title: Text(
                    'High Score',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(highScore),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPlay(),
                        ));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blue, width: 2)),
                      child: Text(
                        "Go home",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPlay(),
                        ));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text("Restart", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget resultSummary(
      {@required BuildContext context,
      @required IconData icon,
      @required Color iconColor,
      @required int valueReported,
      @required int total,
      @required String category}) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 7,
      //color: Colors.grey,
      child: Stack(
        children: [
          Positioned(
            top: 6,
            left: 4,
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          Positioned(
            top: 8,
            right: 16,
            child: Text(
              ' $valueReported / $total',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Text(category),
          )
        ],
      ),
    );
  }

  Future<void> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    int currentHighScore = prefs.getInt('highScore');
    if (prefs.containsKey('highScore')) {
      if (widget.score > currentHighScore) {
        prefs.setInt('highScore', widget.score);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Congratulations, new high score!')));
        setState(() {
          highScore = widget.score.toString();
        });
      } else {
        setState(() {
          highScore = currentHighScore.toString();
        });
      }
    } else {
      if (widget.score > 0) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Congratulations, new high score!')));
      }

      prefs.setInt('highScore', widget.score);
      setState(() {
        highScore = '${widget.score}';
      });
    }
  }

  void share(BuildContext context, $, Set<int> set) {}
}
