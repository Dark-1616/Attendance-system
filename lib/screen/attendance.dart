// ignore_for_file: sort_child_properties_last

import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/components/text_style.dart';
import 'package:attendance_system/message.dart';
import 'package:attendance_system/screen/code_trial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({required this.course, super.key});
  dynamic course;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String code = '';
  Position? currentPosition;
  int distance = 5;
  int duration = 10;
  TextEditingController distanceController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  _copy() {
    final value = ClipboardData(text: code);
    Clipboard.setData(value);
    messagePopup(message: "copied to clipboard");
  }

  bool isGenerating = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            width: 414,
            height: 400,
            child: Stack(
              children: [
                Positioned(
                    top: -20,
                    child: ImageWidget(
                        width: 414, heigth: 407, image: 'Rectangle')),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: headerSection(context: context),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        widget.course["name"],
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.course["matricule"],
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 120),
                      Container(
                          height: 70,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Appcolors.yellow,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: isGenerating
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : SelectableText(
                                              code,
                                              style: textStyle(
                                                  28,
                                                  FontWeight.w500,
                                                  Appcolors.black),
                                            )),
                                  InkWell(
                                      onTap: _copy,
                                      child: const Icon(
                                        Icons.content_copy,
                                      )),
                                ],
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 60),
          buttonWidget(
            action: () => generateCode(),
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
      )),
    );
  }

  //   Future<void> fetchCurrentPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   setState(() {
  //     currentPosition = position;
  //   });
  // }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void storeCode() async {
    setState(() {
      isGenerating = true;
    });
    DateTime now = DateTime.now();
    Position position = await _determinePosition();

    // Store the code and timestamp in Firebase Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference codesCollection = firestore.collection('code');

    try {
      await codesCollection.add({
        'code': code,
        'Time': now,
        'name': widget.course["name"],
        'latitude': position.latitude,
        'longitude': position.longitude,
        'distance': distance,
        "duration": duration,
        "status": 'active'
      });
     
      print('Code stored successfully');
    } catch (e) {
      print('Error storing code: $e');
    }

  }

  void generateCode() {
   
    String value = widget.course['matricule'];
    // String alphabeticPart = value.substring(0, 3);
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
    storeCode();
    
    setState(() {
      code = dividedday.toString() +
          dividedyear.toString() +
          dividednumericValue.toString() +
          dividedmins.toString() +
          dividedscds.toString();
    });
    setState(() {
      isGenerating = false;
    });
  }

  Row headerSection({required BuildContext context}) {
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
                return Container(
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
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  height: 44,
                                  width: 310,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Appcolors.ligthgray)),
                                  child: TextField(
                                      controller: distanceController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          hintText: distance.toString(),
                                          border: InputBorder.none))),
                            ),
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Valide code time',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: 44,
                                    width: 310,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Appcolors.ligthgray)),
                                    child: TextField(
                                      controller: durationController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          hintText: duration.toString(),
                                          border: InputBorder.none),
                                    ))),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(right: 32),
                              child: buttonWidget(
                                action: () {
                                  setState(() {
                                    if (distanceController.text.isNotEmpty) {
                                      distance =
                                          int.parse(distanceController.text);
                                    }
                                    if (durationController.text.isNotEmpty) {
                                      duration =
                                          int.parse(durationController.text);
                                    }
                                  });
                                  Navigator.pop(context);
                                },
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
                        )));
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
}
// }

