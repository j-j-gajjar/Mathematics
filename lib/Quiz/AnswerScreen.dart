import 'package:flutter/material.dart';
import 'package:mathamatics/HomeScreen.dart';
import 'package:mathamatics/Quiz/UserAnswerScreen.dart';
import 'package:mathamatics/customWidget/customWidgetMethods.dart';

class AnswerScreen extends StatelessWidget {
  final score;
  final maxScore;
  final List qustions;
  final List answers;
  final List userAnswer;

  const AnswerScreen({this.score, this.maxScore, this.qustions, this.answers, this.userAnswer});

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
          child: customAppBar(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(score*100/maxScore>75)
            Image.asset("assets/congratulation.gif")
            else if(score*100/maxScore>40)
              Image.asset("assets/nice-try.gif")
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                child: Image.asset("assets/betterluck.png",width: 300,),
              ),
            SizedBox(
              height: 30,
            ),
            Text("YOUR SCROE IS ${score.toString()}", style: TextStyle(fontSize: 25, color:Color(0XFF1ea366),)),
            SizedBox(height: 30,),
            Text("OUT OF ${maxScore.toString()}", style: TextStyle(fontSize: 20, color:Colors.black,)),
            SizedBox(height: 30,),
            MaterialButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
              child: Text("Go To Home ->", style: TextStyle(color: Colors.blueAccent)),
            ),
            SizedBox(height: 30,),
            MaterialButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAnswerScreen(answers: answers, qustions: qustions, userAnswer: userAnswer))),
              child: Text("Check Your Answer", style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
