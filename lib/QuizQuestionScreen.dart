import 'package:flutter/material.dart';
import 'package:mathamatics/QuizScreen.dart';

class QuizQuestionScreen extends StatelessWidget {
  final IconData icon;
  final operator;

  QuizQuestionScreen({Key key, this.icon, this.operator}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ques = TextEditingController();

  final TextEditingController _range1 = TextEditingController();

  final TextEditingController _range2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.pink,
          ),
        ),
        centerTitle: true,
        title: Text(
          "mathematics",
          style: TextStyle(color: Colors.pink),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(parent: ScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Hero(
                tag: icon,
                child: Icon(
                  icon,
                  size: 70,
                  color: Colors.yellow,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MainScreenCard(
                      ques: _ques,
                      icon: icon,
                      max: 3,
                      hint: "How Many Question",
                      maxValue: 100,
                    ),
                    MainScreenCard(
                      ques: _range1,
                      icon: icon,
                      max: 5,
                      hint: "First Value Range",
                    ),
                    MainScreenCard(
                      ques: _range2,
                      icon: icon,
                      max: 5,
                      hint: "Second Value Range",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          oprator: operator,
                          numOfQuestions: _ques.text,
                          range1: _range1.text,
                          range2: _range2.text,
                        ),
                      ),
                    );
                  }
                },
                elevation: 10,
                color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "GENERATE QUIZ",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreenCard extends StatelessWidget {
  const MainScreenCard({
    Key key,
    @required TextEditingController ques,
    @required this.icon,
    this.hint,
    this.max,
    this.maxValue = 999999,
  })  : _ques = ques,
        super(key: key);

  final TextEditingController _ques;
  final IconData icon;
  final String hint;
  final int max;
  final int maxValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        maxLength: max,
        controller: _ques,
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val.isEmpty) {
            return "Requred";
          } else if (int.parse(val) < 2) {
            return "Value must be >3";
          } else if (int.parse(val) > maxValue) {
            return "100 Question Only";
          }
          return null;
        },
        style: TextStyle(color: Colors.yellow, fontSize: 20),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.white),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: hint,
          prefixIcon: Icon(icon),
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
