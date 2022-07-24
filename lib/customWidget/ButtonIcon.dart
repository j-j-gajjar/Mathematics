import 'package:flutter/material.dart';

import '../utils/colorConst.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    super.key,
    required this.icon,
    required this.function,
  });
  final IconData icon;
  final Function() function;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MaterialButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width > 550
              ? 200
              : MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width > 550
              ? 200
              : MediaQuery.of(context).size.width / 3,
          child: Hero(
            tag: icon,
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
