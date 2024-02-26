import 'dart:math' show cos, sqrt, asin;
import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/components/input_button.dart';
import 'package:attendance_system/screen/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StudentAttendancePage extends StatefulWidget {
  StudentAttendancePage({required this.course, super.key});
  dynamic course;
  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  TextEditingController controller = TextEditingController();
  late Position position;
  // The code you want to search for
  List documents = [];
  Future<void> fetchDocuments({required String code}) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('code')
        .where('code', isEqualTo: code)
        .get();
    storeCode();
    print(calculateDistance(
        lat2: snapshot.docs[0]['latitude'],
        lon2: snapshot.docs[0]['longitude'],
        lat1: position.latitude,
        lon1: position.longitude));
    print(snapshot.docs[0]['distance']);

    setState(() {
      documents = snapshot.docs;
    });
  }

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
    // DateTime now = DateTime.now();
    position = await _determinePosition();

    // Store the code and timestamp in Firebase Firestore
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference codesCollection = firestore.collection('code');

    // try {
    //   await codesCollection.add({
    //     'code': code,
    //     'Time': now,
    //     'name': widget.course["name"],
    //     'latitude': position.latitude,
    //     'longitude': position.longitude,
    //     'distance': distance,
    //     "duration": duration,
    //     "status": 'active'
    //   });
    //   print('Code stored successfully');
    // } catch (e) {
    //   print('Error storing code: $e');
    // }
  }

  double calculateDistance(
      {required double lat1,
      required double lon1,
      required double lat2,
      required double lon2}) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var distance = 12742 * asin(sqrt(a));

    // Return the distance in meters
    return distance * 1000;
  }

  // double calculateDistance(
  //     {required double lat1,
  //     required double lon1,
  //     required double lat2,
  //     required double lon2}) {
  //   const double earthRadius = 6371000; // Radius of the Earth in meters

  //   // Convert latitude and longitude from degrees to radians
  //   double lat1Radians = _degreesToRadians(lat1);
  //   double lon1Radians = _degreesToRadians(lon1);
  //   double lat2Radians = _degreesToRadians(lat2);
  //   double lon2Radians = _degreesToRadians(lon2);

  //   // Calculate the differences between the latitudes and longitudes
  //   double latDiff = lat2Radians - lat1Radians;
  //   double lonDiff = lon2Radians - lon1Radians;

  //   // Apply the Haversine formula
  //   double a = pow(sin(latDiff / 2), 2) +
  //       cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDiff / 2), 2);
  //   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //   double distance = earthRadius * c;

  //   return distance;
  // }

  // double _degreesToRadians(double degrees) {
  //   return degrees * pi / 180;
  // }

  @override
  void initState() {
    storeCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: headerSection(context),
          ),
          const SizedBox(height: 60),
          Text(
            widget.course["name"],
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Text(
            widget.course["matricule"],
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 120),
          inputButton(
            context: context,
            label: '',
            controller: controller,
          ),
          const SizedBox(height: 60),
          buttonWidget(
            action: () {
              fetchDocuments(code: controller.text);
            },
            length: 48,
            width: 220,
            radius: 12,
            child: const Center(
              child: Text(
                'Check',
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
                    const Text(
                      'Presence taken',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
      )),
    );
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
    ]);
  }
}
