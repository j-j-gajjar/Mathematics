import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios, color: Colors.pink)),
    title: Text("Mathematics", style: TextStyle(color: Colors.pink)),
    centerTitle: true,
    backgroundColor: Colors.yellow,
    elevation: 0,
  );
}
