import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  CardComponent(
      {Key? key,
      this.width,
      this.height,
      this.color,
      this.shadowColor,
      this.blurRadius,
      this.spreadRadius,
      this.offsetX,
      this.offsetY,
      this.radius,
      this.borderSize,
      this.borderColor,
      this.child,
      this.gradientColors,
      this.begin,
      this.end,
      this.padding,
      this.margin})
      : super(key: key);
  double? width,
      height,
      radius,
      spreadRadius,
      blurRadius,
      offsetX,
      offsetY,
      borderSize;
  Color? color, shadowColor, borderColor;
  Widget? child;
  List<Color>? gradientColors;
  AlignmentGeometry? begin, end;
  EdgeInsets? padding, margin;

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderSize ?? 0),
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          color: widget.color ?? Colors.transparent,
          gradient: widget.gradientColors == null
              ? null
              : LinearGradient(
                  begin: widget.begin ?? Alignment.centerLeft,
                  end: widget.end ?? Alignment.centerRight,
                  colors: widget.gradientColors ??
                      [Colors.transparent, Colors.transparent]),
          boxShadow: [
            BoxShadow(
                spreadRadius: widget.spreadRadius ?? 0,
                blurRadius: widget.blurRadius ?? 0,
                color: widget.shadowColor ?? Colors.transparent,
                offset: Offset(widget.offsetX ?? 0, widget.offsetY ?? 0))
          ]),
      child: widget.child ?? const SizedBox(),
    );
  }
}
