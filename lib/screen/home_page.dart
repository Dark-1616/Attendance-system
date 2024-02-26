import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/screen/add_course.dart';
import 'package:attendance_system/screen/auth/log_in.dart';
import 'package:attendance_system/screen/code_trial.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import 'course.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  PageController _controller = PageController();
  int curentindex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            homePage(context),
          ],
        ),
      ),
    );
  }

  Padding homePage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          // top: pagelength(context: context, value: 30),
          left: 16,
          right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageWidget(width: 50, heigth: 50, image: 'schoologo'),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Appcolors.ligthgray),
                child: ImageWidget(
                  width: 8,
                  heigth: 8,
                  image: 'profile',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 174,
            width: 320,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Appcolors.white,
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 2.5,
                      blurRadius: 2.5,
                      offset: Offset(0, 2.5),
                      color: Appcolors.ligthgray)
                ]),
            child: ScrollDatePicker(
              selectedDate: _selectedDate,
              locale: const Locale('en'),
              onDateTimeChanged: (DateTime value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Addcourses())),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Courses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('+',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          SizedBox(
              width: 500,
              height: 100,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                IconRow(name: 'Table'),
                IconRow(name: 'Chair'),
                IconRow(name: 'Chair'),
                IconRow(name: 'Chair'),
                IconRow(name: 'Sofa'),
                IconRow(name: 'Sofa'),
                IconRow(name: 'Lamp'),
                IconRow(name: 'Cabinet'),
                IconRow(name: 'Lamp')
              ])),
          // SizedBox(height: 160),
          ImageWidget(width: 450, heigth: 400, image: 'class'),
          SizedBox(
            height: 60,
            width: 414,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttomPage(image: 'home'),
                  buttomPage(image: 'book-text'),
                  buttomPage(image: 'parking-circle'),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodeTrial()));
                      },
                      child: buttomPage(image: 'bar-chart-3')),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttomPage({required String image}) {
    return Container(
      height: 52,
      width: 52,
      decoration: const BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Appcolors.ligthgray,
                spreadRadius: 0.25,
                blurRadius: 0.25,
                offset: Offset(0.5, 2)),
            BoxShadow(
                color: Appcolors.ligthgray,
                spreadRadius: 0.25,
                blurRadius: 0.25,
                offset: Offset(-0.5, -0)),
          ],
          color: Appcolors.white,
          borderRadius: BorderRadius.all(Radius.circular(31))),
      child: Center(
          child: ImageWidget(heigth: 25, width: 25, image: image, issvg: true)),
    );
  }
}

Widget IconRow({
  required String name,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 11),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(14),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Appcolors.ligthgray,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
        ),
      ],
    ),
  );
}
