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
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width > 550 ? 200 : width / 2.3,
      height: width > 550 ? 200 : width / 3,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            backgroundColor: baseColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        child: Hero(
          tag: icon,
          child: Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
