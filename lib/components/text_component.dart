import 'package:flutter/material.dart';

class TextComponent extends StatefulWidget {
  TextComponent(
      {Key? key,
      this.id,
      required this.text,
      this.color,
      this.family,
      this.overflow,
      this.size,
      this.weight,
      this.maxLines,
      this.left,
      this.top,
      this.width,
      this.height,
      this.decoration,
      this.textAlign})
      : super(key: key);

  String? id;
  String text;
  Color? color;
  double? size;
  FontWeight? weight;
  String? family;
  TextOverflow? overflow;
  int? maxLines;
  double? left, top, width, height;
  TextAlign? textAlign;
  TextDecoration? decoration;

  @override
  State<TextComponent> createState() => _TextComponentState();
}

class _TextComponentState extends State<TextComponent> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text.toString(),
        maxLines: widget.maxLines,
        textAlign: widget.textAlign ?? TextAlign.start,
        style: TextStyle(
            color: widget.color,
            fontSize: widget.size ?? 16,
            fontWeight: widget.weight,
            // fontFamily: widget.family ?? Fonts.fontRegular,
            letterSpacing: widget.width,
            decoration: widget.decoration,
            overflow: widget.overflow));
  }
}
