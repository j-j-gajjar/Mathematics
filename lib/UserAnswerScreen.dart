import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAnswerScreen extends StatelessWidget {
  final List qustions;
  final List answers;
  final List userAnswer;

  const UserAnswerScreen(
      {Key key, this.qustions, this.answers, this.userAnswer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (c, i) {
              return Card(
                color: Colors.pinkAccent,
                elevation: 10,
                child: ListTile(
                  leading: userAnswer[i].toString() == answers[i].toString()
                      ? CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(FontAwesomeIcons.check),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.red[900],
                          child: Icon(FontAwesomeIcons.times),
                        ),
                  title: Text(
                    qustions[i].toString(),
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(answers[i].toString(),
                      style: TextStyle(color: Colors.yellow, fontSize: 15)),
                  trailing: Text(
                    "${userAnswer[i].toString()}",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              );
            },
            itemCount: answers.length,
          ),
        ),
      ),
    );
  }
}
