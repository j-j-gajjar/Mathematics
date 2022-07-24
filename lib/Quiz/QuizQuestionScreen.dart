import 'package:flutter/material.dart';

import '../customWidget/MainScreenCard.dart';
import '../customWidget/customWidgetMethods.dart';
import '../utils/colorConst.dart';
import 'QuizScreen.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({
    super.key,
    this.icon = Icons.add,
    this.operator = 'sum',
  });
  final IconData icon;
  final String operator;

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
          child: const CustomAppBar(),
        ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(parent: ScrollPhysics()),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Hero(
                  tag: widget.icon,
                  child: Icon(
                    widget.icon,
                    size: 70,
                    color: baseColor,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MainScreenCard(
                          ques: _ques,
                          icon: widget.icon,
                          max: 3,
                          label: 'How Many Question',
                          maxValue: 100,
                          hint: '20'),
                      MainScreenCard(
                          ques: _range1,
                          icon: widget.icon,
                          max: 5,
                          label: 'Start Value',
                          hint: '20'),
                      MainScreenCard(
                          ques: _range2,
                          icon: widget.icon,
                          max: 5,
                          label: 'End Value',
                          hint: '55'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ExpansionTile(
                    title: const Text('Time'),
                    childrenPadding: const EdgeInsets.fromLTRB(30, 2, 30, 10),
                    leading: const Icon(Icons.watch_later_rounded),
                    trailing: Text('${time.toString()}s'),
                    children: [
                      ListTile(
                        title: const Text('5s'),
                        onTap: () {
                          setState(() {
                            time = 5;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('10s'),
                        onTap: () {
                          setState(() {
                            time = 10;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('15s'),
                        onTap: () {
                          setState(() {
                            time = 15;
                          });
                        },
                      ),
                      ListTile(
                        title: const Text('20s'),
                        onTap: () {
                          setState(() {
                            time = 20;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizScreen(
                                operator: widget.operator,
                                numOfQuestions: _ques.text,
                                range1: _range1.text,
                                range2: _range2.text,
                                duration: time)),
                      );
                    }
                  },
                  elevation: 20,
                  color: baseColor,
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('GENERATE QUIZ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600))),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
