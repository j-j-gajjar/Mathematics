import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../customWidget/QuizButtonIcon.dart';
import '../utils/colorConst.dart';
import 'AnswerScreen.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.duration,
    this.operator = 'sum',
    super.key,
    this.numOfQuestions = '5',
    this.range1 = '5',
    this.range2 = '5',
  });
  final String operator;
  final String numOfQuestions;
  final String range1;
  final int duration;

  final String range2;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> questions = [];
  List<dynamic> answers = [];
  bool isMarked = false;
  List<List<dynamic>> mcq = [];
  List<dynamic> userAnswer = [];
  List<dynamic> ansData = [];
  List<dynamic> ans = [];
  var j = 0;
  final CountDownController _controller = CountDownController();
  @override
  void initState() {
    super.initState();
    for (var i = 1; i < int.parse(widget.numOfQuestions) + 1; i++) {
      ans = [];
      final val1 = Random().nextInt(int.parse(widget.range1)) + 1;
      final val2 = Random().nextInt(int.parse(widget.range2)) + 1;
      if (widget.operator == 'sum') {
        questions.add('$val1  +  $val2 =  ? ');
        answers.add(val1 + val2);
        ansData = [
          val1 + val2,
          val1 + val2 + Random().nextInt(10) + 1,
          val1 + val2 - Random().nextInt(10) - 1,
          val1 + val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.operator == 'minus') {
        questions.add('$val1  -  $val2 =  ? ');
        answers.add(val1 - val2);
        ansData = [
          val1 - val2,
          val1 - val2 + Random().nextInt(10) + 1,
          val1 - val2 - Random().nextInt(10) - 1,
          val1 - val2 + Random().nextInt(16) + 1,
        ];
      } else if (widget.operator == 'multiplication') {
        questions.add('$val1  *  $val2 =  ? ');
        answers.add(val1 * val2);
        ansData = [
          val1 * val2,
          val1 * val2 + Random().nextInt(10) + 1,
          val1 * val2 - Random().nextInt(10) - 1,
          val1 * val2 + Random().nextInt(16) + 1,
        ];
      } else {
        questions.add('$val1  /  $val2 =  ? ');
        answers.add((val1 / val2).toStringAsFixed(2));
        ansData = [
          (val1 / val2).toStringAsFixed(2),
          (val1 / val2 + Random().nextInt(10) + 1).toStringAsFixed(2),
          (val1 / val2 - Random().nextInt(10) - 1).toStringAsFixed(2),
          (val1 / val2 + Random().nextInt(16) + 1).toStringAsFixed(2),
        ];
      }
      for (var j = 0; j < 4; j++) {
        final rNum = Random().nextInt(ansData.length).round();
        ans.add(ansData[rNum]);
        ansData.removeAt(rNum);
      }
      mcq.add(ans);
    }
  }

  void _changeQuestion(ans) {
    userAnswer.add(ans);
    if (j + 1 >= questions.length) {
      int score = 0;
      for (var i = 0; i < answers.length; i++) {
        if (userAnswer[i].toString() == answers[i].toString()) {
          score++;
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerScreen(
            maxScore: int.parse(widget.numOfQuestions),
            score: score,
            answers: answers,
            questions: questions,
            userAnswer: userAnswer,
          ),
        ),
      );
    } else {
      setState(() {
        ++j;
        isMarked = false;
      });
      _controller.restart(duration: widget.duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularCountDownTimer(
                      duration: widget.duration,
                      controller: _controller,
                      width: MediaQuery.of(context).size.width > 500
                          ? MediaQuery.of(context).size.width / 10
                          : MediaQuery.of(context).size.width / 6,
                      height: MediaQuery.of(context).size.height / 2,
                      ringColor: Colors.grey[300] ?? Colors.grey,
                      fillColor: baseColor,
                      backgroundColor: Colors.white,
                      strokeWidth: 20.0,
                      textStyle: const TextStyle(
                          fontSize: 33.0,
                          color: baseColorLight,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.SS,
                      isReverse: true,
                      onStart: () {},
                      onComplete: () {
                        if (!isMarked) {
                          _changeQuestion('TimeOut');
                        }
                      }),
                  Text(questions[j].toString(),
                      style: TextStyle(
                          color: baseColor,
                          fontSize:
                              MediaQuery.of(context).size.width > 500 ? 45 : 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _changeQuestion(mcq[j][0].toString());
                          },
                          child: QuizButtonIcon(option: mcq[j][0].toString())),
                      GestureDetector(
                          onTap: () {
                            _changeQuestion(mcq[j][1].toString());
                          },
                          child: QuizButtonIcon(option: mcq[j][1].toString())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _changeQuestion(mcq[j][2].toString());
                          },
                          child: QuizButtonIcon(option: mcq[j][2].toString())),
                      GestureDetector(
                          onTap: () {
                            _changeQuestion(mcq[j][3].toString());
                          },
                          child: QuizButtonIcon(option: mcq[j][3].toString())),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
