import 'package:flutter/material.dart';
import 'customWidgetMethods.dart';

AppBar sharedAppBar() {
  return AppBar(flexibleSpace: const CustomAppBar());
}
