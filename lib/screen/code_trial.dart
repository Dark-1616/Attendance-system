import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/text_style.dart';
import 'package:attendance_system/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeTrial extends StatefulWidget {
  CodeTrial({super.key});

  @override
  State<CodeTrial> createState() => _CodeTrialState();
}

TextEditingController controller = TextEditingController();

class _CodeTrialState extends State<CodeTrial> {
  String code = '';

  @override
  void initState() {
    String value = "ABC2460";
    String alphabeticPart = value.substring(0, 3);
    String numericPart = value.substring(3);

    int numericValue;
    numericValue = int.parse(numericPart);
    DateTime Date = DateTime.now();

    // String date = ('${Date.year}-${Date.month}-${Date.day}');
    int numericyear =
        int.parse(Date.year.toString()[2]) + int.parse(Date.year.toString()[3]);

    int numericday =
        int.parse(Date.day.toString()[0]) + int.parse(Date.day.toString()[1]);

    String time = '${Date.hour}:${Date.minute}:${Date.second}';
    List<String> parts = time.split(":");
    String minutes = parts[1];
    String seconds = parts[2];
    int scds = int.parse(seconds);
    int mins = int.parse(minutes);

    int dividedday = numericday ~/ 2;
    int dividedyear = numericyear ~/ 2;
    int dividednumericValue = numericValue ~/ 2;
    int dividedmins = mins ~/ 2;
    int dividedscds = scds ~/ 2;
    code = dividedday.toString() +
        dividedyear.toString() +
        dividednumericValue.toString() +
        dividedmins.toString() +
        dividedscds.toString();
    super.initState();
  }

  _copy() {
    final value = ClipboardData(text: code);
    Clipboard.setData(value);
    messagePopup(message: "copied to clipboard");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Container(
            height: 70,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Appcolors.yellow,
            ),
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                        child: SelectableText(
                      code,
                      style: textStyle(28, FontWeight.w500, Appcolors.white),
                    )),
                    InkWell(
                        onTap: _copy,
                        child: Icon(
                          Icons.content_copy,
                          color: Appcolors.white,
                        )),
                  ],
                ))),
      )
    ])));
  }
}
