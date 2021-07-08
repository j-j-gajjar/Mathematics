import 'package:flutter/material.dart';

class DisplayButton extends StatelessWidget {
  final String text;
  final Function function;

  const DisplayButton({Key key, this.text, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: (MediaQuery.of(context).size.height * 50) / 816,
        width: MediaQuery.of(context).size.width > 550 ? 300 : double.infinity,
        child: Center(child: Text(text, style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: (MediaQuery.of(context).size.height * 30) / 816))),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.yellow),
      ),
    );
  }
}
