import 'package:flutter/material.dart';

class MainScreenCard extends StatelessWidget {
  const MainScreenCard({Key key, @required TextEditingController ques, @required this.icon, this.lable, this.max, this.maxValue = 999999, this.hint})
      : _ques = ques,
        super(key: key);

  final TextEditingController _ques;
  final IconData icon;
  final String lable;
  final String hint;
  final int max;
  final int maxValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width > 700 ? 500 : double.infinity,
      child: TextFormField(
        maxLength: max,
        controller: _ques,
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val.isEmpty) {
            return "Please input something";
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
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 3), borderRadius: BorderRadius.circular(16)),
          labelText: lable,
          prefixIcon: Icon(icon),
          hintStyle: TextStyle(color: Colors.white),
          hintText: hint,
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
