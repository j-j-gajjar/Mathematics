import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathamatics/AnswerScreen.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  final String oprator;
  final String numOfQuestions;
  final String range1;
  final String range2;

  QuizScreen(
      {Key key,
      this.oprator,
      this.numOfQuestions = "5",
      this.range1 = "5",
      this.range2 = "5"});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List qustions = [];
  List answers = [];
  List<List<dynamic>> mcq = [];
  List userAnswer = [];
  var ansData;
  List<dynamic> ans = [];
  var j = 0;
  MobileAdTargetingInfo targetingInfo;
  BannerAd myBanner;
  @override
  void initState() {
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['maths', 'education', 'school', 'college', 'study'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now(),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.unknown,
      testDevices: <String>[], // Android emulators are considered test devices
    );
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-8093789261096390/7459574110',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    super.initState();
    for (var i = 1; i < int.parse(widget.numOfQuestions) + 1; i++) {
      ans = [];
      var val1 = Random().nextInt(int.parse(widget.range1)) + 1;
      var val2 = Random().nextInt(int.parse(widget.range2)) + 1;
      if (widget.oprator == "sum") {
        qustions.add("$val1  +  $val2 =  ? ");
        answers.add(val1 + val2);
        ansData = [
          val1 + val2,
          val1 + val2 + Random().nextInt(10) + 1,
          val1 + val2 - Random().nextInt(10) - 1,
          val1 + val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.oprator == "minus") {
        qustions.add("$val1  -  $val2 =  ? ");
        answers.add(val1 - val2);
        ansData = [
          val1 - val2,
          val1 - val2 + Random().nextInt(10) + 1,
          val1 - val2 - Random().nextInt(10) - 1,
          val1 - val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.oprator == "multification") {
        qustions.add("$val1  *  $val2 =  ? ");
        answers.add(val1 * val2);
        ansData = [
          val1 * val2,
          val1 * val2 + Random().nextInt(10) + 1,
          val1 * val2 - Random().nextInt(10) - 1,
          val1 * val2 + Random().nextInt(16) + 1,
        ];
      } else {
        qustions.add("$val1  /  $val2 =  ? ");
        answers.add(val1 / val2);
        ansData = [
          val1 / val2,
          val1 / val2 + Random().nextInt(10) + 1,
          val1 / val2 - Random().nextInt(10) - 1,
          val1 / val2 + Random().nextInt(16) + 1,
        ];
      }
      for (var j = 0; j < 4; j++) {
        var rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
  }

  _changeQuestion(ans) {
    userAnswer.add(ans);
    if (j + 1 >= qustions.length) {
      var score = 0;
      for (var i = 0; i < answers.length; i++) {
        if (userAnswer[i].toString() == answers[i].toString()) {
          score++;
        }
      }
      myBanner.dispose();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerScreen(
            maxScore: int.parse(widget.numOfQuestions),
            score: score,
            answers: answers,
            qustions: qustions,
            userAnswer: userAnswer,
          ),
        ),
      );
    } else {
      setState(() {
        j++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              qustions[j].toString(),
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _changeQuestion(mcq[j][0].toString()),
                  child: ButtonIcon(
                    option: mcq[j][0].toString(),
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeQuestion(mcq[j][1].toString()),
                  child: ButtonIcon(
                    option: mcq[j][1].toString(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _changeQuestion(mcq[j][2].toString()),
                  child: ButtonIcon(
                    option: mcq[j][2].toString(),
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeQuestion(mcq[j][3].toString()),
                  child: ButtonIcon(
                    option: mcq[j][3].toString(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final String option;

  const ButtonIcon({this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          option,
          style: TextStyle(color: Colors.yellow, fontSize: 25),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      width: MediaQuery.of(context).size.width > 550
          ? 300
          : MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width > 550
          ? 100
          : MediaQuery.of(context).size.width / 7,
    );
  }
}
