import 'package:flutter/material.dart';
import 'package:mathamatics/AskOperator.dart';
import 'package:mathamatics/customWidget/DisplayButton.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              physics: ScrollPhysics(parent: ScrollPhysics()),
              child: Column(
                children: [
                  DisplayButton(text: "Generate PDF", function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AskOperator(isQuiz: false)))),
                  SizedBox(height: (MediaQuery.of(context).size.height * 20) / 816),
                  DisplayButton(text: "Quiz", function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AskOperator(isQuiz: true)))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
