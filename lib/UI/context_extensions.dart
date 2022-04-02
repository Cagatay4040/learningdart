import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHight(double val) => MediaQuery.of(this).size.height * val;
  bool isPortrait() => MediaQuery.of(this).orientation == Orientation.portrait;
}
