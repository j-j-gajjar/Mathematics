import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathamatics/customWidget/customWidgetMethods.dart';

class UserAnswerScreen extends StatefulWidget {
  final List qustions;
  final List answers;
  final List userAnswer;

  const UserAnswerScreen({Key key, this.qustions, this.answers, this.userAnswer}) : super(key: key);

  @override
  _UserAnswerScreenState createState() => _UserAnswerScreenState();
}

class _UserAnswerScreenState extends State<UserAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: customAppBar(context),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width > 700 ? 600 : double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (c, i) {
                      return Card(
                        color: Colors.amberAccent,
                        elevation: 10,
                        child: ListTile(
                          leading: widget.userAnswer[i].toString() == widget.answers[i].toString()
                              ? CircleAvatar(backgroundColor: Colors.green, child: Icon(FontAwesomeIcons.check))
                              : CircleAvatar(backgroundColor: Colors.red[900], child: Icon(FontAwesomeIcons.times)),
                          title: Text(widget.qustions[i].toString(), style: TextStyle(color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text("Answer = ${widget.answers[i].toString()}", style: TextStyle(color: Colors.green, fontSize: 15)),
                          trailing: Text("${widget.userAnswer[i].toString()}", style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      );
                    },
                    itemCount: widget.answers.length,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
