import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathamatics/QuestionScreen.dart';

class HomeScreenQuesion extends StatelessWidget {
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
        title: Text(
          "mathematics",
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: AppBody(),
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: ScrollPhysics()),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonIcon(
                        icon: FontAwesomeIcons.plus,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                icon: FontAwesomeIcons.plus,
                                operator: "sum",
                              ),
                            ),
                          );
                        }),
                    ButtonIcon(
                        icon: FontAwesomeIcons.minus,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                icon: FontAwesomeIcons.minus,
                                operator: "minus",
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonIcon(
                        icon: FontAwesomeIcons.times,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                icon: FontAwesomeIcons.times,
                                operator: "multification",
                              ),
                            ),
                          );
                        }),
                    ButtonIcon(
                        icon: FontAwesomeIcons.divide,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                icon: FontAwesomeIcons.divide,
                                operator: "divition",
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Function function;

  const ButtonIcon({this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlatButton(
        onPressed: function,
        child: Container(
          child: Hero(
            tag: icon,
            child: Icon(
              icon,
              size: 50,
              color: Colors.yellow,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
              width: 10,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          width: MediaQuery.of(context).size.width > 550
              ? 300
              : MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width > 550
              ? 300
              : MediaQuery.of(context).size.width / 3,
        ),
      ),
    );
  }
}
