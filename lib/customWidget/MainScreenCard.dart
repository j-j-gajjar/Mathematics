import 'package:flutter/material.dart';

import '../utils/colorConst.dart';

class MainScreenCard extends StatelessWidget {
  const MainScreenCard({
    super.key,
    required TextEditingController ques,
    required this.icon,
    required this.label,
    required this.max,
    this.maxValue = 999999,
    required this.hint,
  }) : _ques = ques;

  final TextEditingController _ques;
  final IconData icon;
  final String label;
  final String hint;
  final int max;
  final int maxValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width > 700 ? 500 : double.infinity,
      child: TextFormField(
        maxLength: max,
        controller: _ques,
        keyboardType: TextInputType.number,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Please input something';
          } else if (int.parse(val) < 2) {
            return 'Value must be >3';
          } else if (int.parse(val) > maxValue) {
            return '100 Question Only';
          }
          return null;
        },
        style: const TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: redColorLight),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: redColorLight),
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: baseColorLight, width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: Icon(icon),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
