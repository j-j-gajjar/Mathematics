import 'package:flutter/material.dart';
import 'package:mathamatics/HomeScreen.dart';
import 'package:mathamatics/Quiz/UserAnswerScreen.dart';

class AnswerScreen extends StatelessWidget {
  final score;
  final maxScore;
  final List qustions;
  final List answers;
  final List userAnswer;

  const AnswerScreen(
      {this.score,
      this.maxScore,
      this.qustions,
      this.answers,
      this.userAnswer});

  @override
  Widget build(BuildContext context) {
    double percent = score / maxScore * 100;
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Text("YOUR SCORE IS ${score.toString()}",
                    style: TextStyle(fontSize: 25, color: Colors.yellow)),
                Text("OUT OF ${maxScore.toString()}",
                    style: TextStyle(fontSize: 20, color: Colors.yellow)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
              child: Text(
                '${percent.toStringAsPrecision(4)} %',
                style: TextStyle(color: Colors.yellow, fontSize: 45),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: MaterialButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen())),
                child: Text("Go To Home ->",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: MaterialButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAnswerScreen(
                            answers: answers,
                            qustions: qustions,
                            userAnswer: userAnswer))),
                child: Text("Check Your Answer",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
