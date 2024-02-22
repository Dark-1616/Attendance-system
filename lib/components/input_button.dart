import 'package:attendance_system/components/constant/size.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class inputButton extends StatelessWidget {
  const inputButton({
    super.key,
    required this.context,
    required this.label,
    this.controller
  });

  final BuildContext context;
  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: pagewidth(context: context, value: 14)),
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 357,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Appcolors.black,
                spreadRadius: 0.05,
                blurRadius: 0.05,
              )
            ], color: Appcolors.white, borderRadius: BorderRadius.circular(10)),
          ),
          Opacity(
            opacity: 1,
            child: Container(
              height: 50,
              width: 357,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: label,
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Appcolors.black),
                      //border: null
                      border: InputBorder.none),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
