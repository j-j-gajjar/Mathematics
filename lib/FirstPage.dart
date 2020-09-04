import 'package:flutter/material.dart';
import 'package:mathamatics/HomeScreenQuestion.dart';
import 'package:mathamatics/QuizHomeScreen.dart';

class FirstPage extends StatelessWidget {
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
                  DisplayButton(
                      text: "Generate",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreenQuesion(),
                          ),
                        );
                      }),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height * 20) / 816,
                  ),
                  DisplayButton(
                      text: "Quiz",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizHomeScreen(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayButton extends StatelessWidget {
  final String text;
  final Function function;

  const DisplayButton({Key key, this.text, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: (MediaQuery.of(context).size.height * 50) / 816,
        width: MediaQuery.of(context).size.width > 550 ? 300 : double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: (MediaQuery.of(context).size.height * 30) / 816,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.yellow,
        ),
      ),
    );
  }
}
