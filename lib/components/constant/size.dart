import 'package:flutter/material.dart';

double pagelength({required BuildContext context, required double value}) {
  return ((MediaQuery.sizeOf(context).height * value) / 896);
}

double pagewidth({required BuildContext context, required double value}) {
  return ((MediaQuery.sizeOf(context).height * value) / 414);
}

Widget heightSpace(double height) {
  return SizedBox(height: height);
}

Widget widthSpace(double width) {
  return SizedBox(width: width);
}