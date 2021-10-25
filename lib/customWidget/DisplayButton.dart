import 'package:flutter/material.dart';
class DisplayButton extends StatelessWidget {
  final String text;
  final Function function;
  const DisplayButton({Key key, this.text, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: (MediaQuery.of(context).size.height * 50) / 816,
          width: MediaQuery.of(context).size.width > 550 ? 300 : double.infinity,
          child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing:5,  fontSize: (MediaQuery.of(context).size.height * 30) / 816))),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color:  Color(0XFF1ea366),),
        ),
      ),
    );
  }
}
