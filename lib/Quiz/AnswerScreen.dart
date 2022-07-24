import 'package:flutter/material.dart';

import '../HomeScreen.dart';
import '../customWidget/customWidgetMethods.dart';
import '../utils/colorConst.dart';
import 'UserAnswerScreen.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({
    super.key,
    required this.score,
    required this.maxScore,
    required this.questions,
    required this.answers,
    required this.userAnswer,
  });
  final int score;
  final int maxScore;
  final List<dynamic> questions;
  final List<dynamic> answers;
  final List<dynamic> userAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CustomAppBar(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (score * 100 / maxScore > 75 == true)
              Image.asset('assets/congratulation.gif')
            else if (score * 100 / maxScore > 40 == true)
              Image.asset('assets/nice-try.gif')
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                child: Image.asset(
                  'assets/betterluck.png',
                  width: 300,
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            Text('YOUR SCORE IS ${score.toString()}',
                style: const TextStyle(
                  fontSize: 25,
                  color: baseColorLight,
                )),
            const SizedBox(
              height: 30,
            ),
            Text('OUT OF ${maxScore.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
              child: const Text('Go To Home ->',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserAnswerScreen(
                          answers: answers,
                          questions: questions,
                          userAnswer: userAnswer))),
              child: const Text('Check Your Answer',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
