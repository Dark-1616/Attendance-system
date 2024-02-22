// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatefulWidget {
  AppIcon(
      {Key? key,
      required this.icon,
      this.size,
      this.color,
      this.center,
      this.dynamicSize,
      this.globalKey})
      : super(key: key);
  String icon;
  double? size;
  Color? color;
  bool? center;
  bool? dynamicSize;
  final GlobalKey? globalKey;
  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  Widget _icon() {
    return SvgPicture.asset("assets/icons/${widget.icon}.svg",
        width: _dynamicSize() ? null : widget.size ?? 20,
        height: _dynamicSize() ? null : widget.size ?? 20,
        fit: _dynamicSize() ? BoxFit.contain : BoxFit.cover,
        color: widget.color ?? Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return widget.center != null
        ? _icon()
        : Center(key: widget.globalKey, child: _icon());
  }

  bool _dynamicSize() {
    return widget.size != null ? false : true;
  }
}
