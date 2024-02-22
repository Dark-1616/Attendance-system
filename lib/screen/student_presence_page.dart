import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/image.dart';
import 'package:flutter/material.dart';

class StudentAttendancePage extends StatefulWidget {
  StudentAttendancePage({required this.course, super.key});
  dynamic course;
  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
  TextEditingController _controller = TextEditingController();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
            width: 414,
            height: 400,
            child: Stack(children: [
              Positioned(
                  top: -20,
                  child:
                      ImageWidget(width: 414, heigth: 407, image: 'Rectangle')),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: headerSection(context),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      widget.course["name"],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.course["code"],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ])),
              const SizedBox(height: 120),
              TextFormField(),
              Container(
                  height: 60,
                  width: 240,
                  child: Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: ('code'),
                      border: InputBorder.none,
                      labelStyle: TextStyle(fontSize: 30),
                    ),
                  )))
            ])),
        const SizedBox(height: 60),
        buttonWidget(
          length: 48,
          width: 220,
          radius: 12,
          child: const Center(
            child: Text(
              'Generate code',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
        ),
        const SizedBox(height: 23),
        buttonWidget(
            length: 48,
            width: 220,
            radius: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Presence taken',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Appcolors.ligthgray,
                        border: Border.all(color: Appcolors.gray)),
                  )
                ],
              ),
            )),
      ],
    ));
  }

  Row headerSection(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              child: ImageWidget(width: 23, heigth: 24, image: 'Arrow'),
            ),
          )),
      settingPart(context)
    ]);
  }

  GestureDetector settingPart(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      width: 414,
                      height: 400,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 32, left: 46),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Distance',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 44,
                                    width: 310,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Appcolors.ligthgray)),
                                    child: const TextField(
                                        decoration: InputDecoration(
                                            label: Text('Distance in meters'),
                                            border: InputBorder.none))),
                              ),
                              const SizedBox(height: 30),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Valide code time',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      height: 44,
                                      width: 310,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Appcolors.ligthgray)),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('00:00:00'),
                                                ImageWidget(
                                                    width: 24,
                                                    heigth: 24,
                                                    image: 'timer')
                                              ],
                                            ),
                                            border: InputBorder.none),
                                      ))),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 32),
                                child: buttonWidget(
                                  child: const Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  width: 200,
                                  length: 48,
                                ),
                              )
                            ],
                          ))));
            });
      },
      child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              color: Appcolors.deepyellow,
              borderRadius: BorderRadius.circular(12)),
          child: ImageWidget(width: 23, heigth: 24, image: 'settings')),
    );
  }
}
