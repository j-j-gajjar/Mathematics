import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathamatics/customWidget/customWidgetMethods.dart';

class UserAnswerScreen extends StatefulWidget {
  final List qustions;
  final List answers;
  final List userAnswer;

  const UserAnswerScreen({
    Key? key,
    required this.qustions,
    required this.answers,
    required this.userAnswer,
  }) : super(key: key);

  @override
  _UserAnswerScreenState createState() => _UserAnswerScreenState();
}

class _UserAnswerScreenState extends State<UserAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width > 700
                    ? 600
                    : double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Card(
                      color: Color(0XFF1ea366),
                      elevation: 10,
                      child: ListTile(
                        leading: widget.userAnswer[i].toString() ==
                                widget.answers[i].toString()
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: Color(0XFF1ea366),
                                ))
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.xmark,
                                  color: Colors.red[900],
                                )),
                        title: Text(widget.qustions[i].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "Answer = ${widget.answers[i].toString()}",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15)),
                        trailing: Text("${widget.userAnswer[i].toString()}",
                            style: TextStyle(
                                fontSize: 20, color: Colors.orangeAccent)),
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
    );
  }
}
