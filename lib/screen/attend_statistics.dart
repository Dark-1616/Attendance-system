import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/text_component.dart';
import 'package:attendance_system/screen/student_presence_page.dart';
import 'package:flutter/material.dart';

import '../components/image.dart';
import 'attendance.dart';

class AttendStat extends StatefulWidget {
  AttendStat({required this.course, super.key});
  dynamic course;

  @override
  State<AttendStat> createState() => _AttendStatState();
}

class _AttendStatState extends State<AttendStat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.white,
        body: Stack(
          children: [
            Container(
                height: pagelength(context: context, value: 320),
                decoration:
                    const BoxDecoration(color: Appcolors.yellow, boxShadow: [
                  BoxShadow(
                      color: Appcolors.ligthgray,
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 1))
                ])),
            Padding(
              padding: EdgeInsets.only(
                  top: pagelength(context: context, value: 220),
                  left: 22,
                  right: 12),
              child: Container(
                height: 150,
                width: 370,
                decoration: BoxDecoration(
                    color: Appcolors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      // BoxShadow(
                      //     color: Appcolors.ligthgray,
                      //     blurRadius: 0.5,
                      //     spreadRadius: 0.5,
                      //     offset: Offset(0, -1))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                color: Appcolors.deepyellow,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageWidget(
                                    width: 23, heigth: 24, image: 'Arrow'),
                              ),
                            )),
                        Container(
                            height: 40,
                            width: 44,
                            decoration: BoxDecoration(
                                color: Appcolors.deepyellow,
                                borderRadius: BorderRadius.circular(12)),
                            child: ImageWidget(
                                width: 23, heigth: 24, image: 'settings')),
                      ]),
                  Center(
                    child: TextComponent(
                      text: widget.course["name"],
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextComponent(
                      text: widget.course["matricule"],
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ImageWidget(
                    heigth: pagelength(context: context, value: 360),
                    width: pagewidth(context: context, value: 354),
                    image: 'classmates',
                  ),
                  const SizedBox(height: 30),
                  buttonWidget(
                      length: 50,
                      width: 280,
                      radius: 12,
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendancePage(
                                      course: widget.course,
                                    )));
                      },
                      child: const Center(
                        child: Text(
                          'Attendance',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      )),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: buttonWidget(
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentAttendancePage(
                                      course: widget.course)));
                        },
                        length: 50,
                        width: 280,
                        radius: 12,
                        child: const Center(
                          child: Text(
                            'Statistics',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                ],
              ),
            )

            //   Container(
            //     height: pagelength(context: context, value: 320),
            //     decoration:
            //         const BoxDecoration(color: Appcolors.yellow, boxShadow: [
            //       BoxShadow(
            //           color: Appcolors.ligthgray,
            //           blurRadius: 2,
            //           spreadRadius: 2,
            //           offset: Offset(0, 1))
            //     ]),
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 160, right: 8, left: 8),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Container(
            //               height: 40,
            //               width: 44,
            //               decoration: BoxDecoration(
            //                   color: Appcolors.deepyellow,
            //                   borderRadius: BorderRadius.circular(12)),
            //               child:
            //                   ImageWidget(width: 23, heigth: 24, image: 'Arrow')),
            //           Container(
            //               height: 40,
            //               width: 44,
            //               decoration: BoxDecoration(
            //                   color: Appcolors.deepyellow,
            //                   borderRadius: BorderRadius.circular(12)),
            //               child: ImageWidget(
            //                   width: 23, heigth: 24, image: 'settings')),
            //         ],
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(
            //         top: pagelength(context: context, value: 100)),
            //     child: const Column(
            //       children: [
            //         Center(
            //           child: Text(
            //             ' Mathematics',
            //             style:
            //                 TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //         Center(
            //           child: Text(
            //             'mth 350',
            //             style:
            //                 TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   Padding(
            //       padding: EdgeInsets.only(
            //           top: pagelength(context: context, value: 220),
            //           left: 22,
            //           right: 12),
            //       child: Column(
            //         children: [
            //           Container(
            //               height: 450,
            //               width: 370,
            //               decoration: BoxDecoration(
            //                   color: Appcolors.black,
            //                   borderRadius: BorderRadius.circular(30)),
            //               child: Padding(
            //                   padding: const EdgeInsets.only(bottom: 90),
            //                   child: ImageWidget(
            //                     heigth: pagelength(context: context, value: 360),
            //                     width: pagewidth(context: context, value: 354),
            //                     image: 'classmates',
            //                   ))),
            //           Padding(
            //             padding: const EdgeInsets.only(bottom: 50),
            //             child: buttonWidget(
            //                 child: Text(
            //               'Attendance',
            //               style: TextStyle(
            //                   fontSize: 36, fontWeight: FontWeight.w700),
            //             )),
            //           ),
            //           buttonWidget(
            //               child: Text(
            //             'Statistics',
            //             style:
            //                 TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            //           )),
            //         ],
            //       )),
          ],
        ),
      ),
    );
  }
}
