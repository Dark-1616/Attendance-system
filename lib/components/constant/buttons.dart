import 'package:attendance_system/components/colors.dart';
import 'package:flutter/material.dart';

class buttonWidget extends StatelessWidget {
  buttonWidget(
      {super.key,
      required this.child,
      this.length,
      this.width,
      this.color,
      this.radius,
      this.action});
  double? length;
  double? width;
  Color? color;
  Widget child;
  Function()? action;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action ?? () {},
      child: Container(
        width: width ?? 178,
        height: length ?? 50,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolors.yellow),
          borderRadius: BorderRadius.circular(radius ?? 12),
          color: color ?? Appcolors.yellow,
        ),
        child: child,
      ),
    );
  }
}
