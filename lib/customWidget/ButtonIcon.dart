import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final Function function;

  const ButtonIcon({this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MaterialButton(
        onPressed: function,
        child: Container(
          child: Hero(tag: icon, child: Icon(icon, size: 50, color: Colors.yellow)),
          decoration: BoxDecoration(border: Border.all(color: Colors.yellow, width: 10), borderRadius: BorderRadius.circular(30)),
          width: MediaQuery.of(context).size.width > 550 ? 300 : MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width > 550 ? 300 : MediaQuery.of(context).size.width / 3,
        ),
      ),
    );
  }
}
