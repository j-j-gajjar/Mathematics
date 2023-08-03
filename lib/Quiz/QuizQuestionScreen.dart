import 'package:flutter/material.dart';
import 'package:mathamatics/Quiz/QuizScreen.dart';
import 'package:mathamatics/customWidget/MainScreenCard.dart';
import 'package:mathamatics/customWidget/customWidgetMethods.dart';

class QuizQuestionScreen extends StatefulWidget {
  final IconData icon;
  final operator;

  QuizQuestionScreen({Key? key, this.icon = Icons.add, this.operator = "sum"})
      : super(key: key);

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ques = TextEditingController();

  final TextEditingController _range1 = TextEditingController();

  final TextEditingController _range2 = TextEditingController();
  var time = 10;

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
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: ScrollPhysics()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Hero(
                    tag: widget.icon,
                    child:
                        Icon(widget.icon, size: 70, color: Color(0XFF1ea366))),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainScreenCard(
                          ques: _ques,
                          icon: widget.icon,
                          max: 3,
                          lable: "How Many Question",
                          maxValue: 100,
                          hint: '20'),
                      MainScreenCard(
                          ques: _range1,
                          icon: widget.icon,
                          max: 5,
                          lable: "Start Value",
                          hint: '20'),
                      MainScreenCard(
                          ques: _range2,
                          icon: widget.icon,
                          max: 5,
                          lable: "End Value",
                          hint: '55'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ExpansionTile(
                    title: Text("Time"),
                    childrenPadding: EdgeInsets.fromLTRB(30, 2, 30, 10),
                    leading: Icon(Icons.watch_later_rounded),
                    trailing: Text("${time.toString()}s"),
                    children: [
                      ListTile(
                        title: Text("5s"),
                        onTap: () {
                          setState(() {
                            time = 5;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("10s"),
                        onTap: () {
                          setState(() {
                            time = 10;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("15s"),
                        onTap: () {
                          setState(() {
                            time = 15;
                          });
                        },
                      ),
                      ListTile(
                        title: Text("20s"),
                        onTap: () {
                          setState(() {
                            time = 20;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizScreen(
                                oprator: widget.operator,
                                numOfQuestions: _ques.text,
                                range1: _range1.text,
                                range2: _range2.text,
                                duration: time)),
                      );
                    }
                  },
                  elevation: 20,
                  color: Color(0XFF1ea366),
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("GENERATE QUIZ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600))),
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
