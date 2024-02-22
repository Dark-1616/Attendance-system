import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget(
      {required this.width,
      required this.heigth,
      required this.image,
      this.fit,
      this.issvg,
      this.svgcolor,
      super.key});
  final double width;
  final double heigth;
  bool? issvg = false;
  final String image;
  final BoxFit? fit;
  Color? svgcolor;

  @override
  Widget build(BuildContext context) {
    return issvg == true
        ? SizedBox(
            height: heigth,
            width: width,
            child: SvgPicture.asset('assets/images/svg/$image.svg'),

            // SvgPicture.asset('assets/images/svg_images/${image}.svg',
            // height: heigth,
            // width: width,
            // fit: BoxFit.contain,

            // ),
          )
        : SizedBox(
            height: heigth,
            width: width,
            child: Image(image: AssetImage('assets/images/$image.png')));
  }
}
