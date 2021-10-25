import 'package:flutter/material.dart';

class QuizButtonIcon extends StatelessWidget {
  final String option;

  const QuizButtonIcon({this.option});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(option, style: TextStyle(color: Color(0XFF1ea366), fontSize: 25))),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color:Color(0XFF1ea366), width: 2), borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width > 550 ? 200 : MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width > 550 ? 50 : MediaQuery.of(context).size.width / 7,
    );
  }
}
