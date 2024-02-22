import 'dart:math';

import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({required this.course, super.key});
  dynamic course;
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          width: 414,
          height: 400,
          child: Stack(
            children: [
              Positioned(
                  top: -20,
                  child:
                      ImageWidget(width: 414, heigth: 407, image: 'Rectangle')),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    const SizedBox(height: 120),
                    Container(
                      width: 150,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Appcolors.ligthyellow),
                      child: Center(
                        child: Text(
                          (100000 + Random().nextInt(900000)).toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 60),
        GestureDetector(
          onTap: () => generateAndStoreCode(),
          child: buttonWidget(
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
        ),
        const SizedBox(height: 23),
        buttonWidget(
            length: 48,
            width: 220,
            radius: 12,
            child: const Center(
              child: Text(
                'Activate code',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            )),
        const SizedBox(height: 23),
        buttonWidget(
            length: 48,
            width: 220,
            radius: 12,
            child: const Center(
              child: Text(
                'Desactivate code',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ))
      ],
    ));
  }

  void generateAndStoreCode() async {
    // Generate a random code
    code = generateCode();

    // Get the current date and time
    DateTime now = DateTime.now();

    // Store the code and timestamp in Firebase Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference codesCollection = firestore.collection('codes');

    try {
      await codesCollection.add({
        'code': code,
        'timestamp': now,
      });
      print('Code stored successfully');
    } catch (e) {
      print('Error storing code: $e');
    }

    setState(() {});
  }

  String generateCode() {
    // Generate your code here
    // You can use any logic or algorithm to generate the code
    // For simplicity, let's generate a random 6-digit code
    return (100000 + Random().nextInt(900000)).toString();
  }
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
    GestureDetector(
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
    )
  ]);
}
