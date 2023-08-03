import 'package:flutter/material.dart';
import 'package:mathamatics/AskOperator.dart';
import 'package:mathamatics/customWidget/DisplayButton.dart';

import 'customWidget/customWidgetMethods.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  backgroundColor: Colors.pinkAccent,
      */
      backgroundColor: Colors.white,
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
      body: Container(
        height: double.infinity,
        /* padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),*/
        padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
        child: Center(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Image.asset("assets/HomeScreen.jpg")),
              SizedBox(
                height: 50,
              ),
              DisplayButton(
                  text: "Generate PDF",
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AskOperator(isQuiz: false)))),
              SizedBox(height: (MediaQuery.of(context).size.height * 20) / 816),
              DisplayButton(
                  text: "Quiz",
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AskOperator(isQuiz: true)))),
            ],
          ),
        ),
      ),
    );
  }
}
