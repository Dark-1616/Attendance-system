import 'package:attendance_system/components/card_component.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/components/text_component.dart';
import 'package:attendance_system/screen/attend_statistics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addcourses extends StatefulWidget {
  const Addcourses({super.key});

  @override
  State<Addcourses> createState() => _AddcoursesState();
}

class _AddcoursesState extends State<Addcourses> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
                width: 486,
                height: 130,
                child: Stack(
                  children: [
                    ImageWidget(width: 486, heigth: 120, image: 'Ellipse 27'),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Appcolors.deepyellow,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ImageWidget(
                                        width: 10, heigth: 10, image: 'Arrow'),
                                  ),
                                )),
                            Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Appcolors.deepyellow,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Center(
                                    child: Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )))
                          ],
                        ))
                  ],
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('course')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot course = snapshot.data!.docs[index];
                          String name = course['name'];
                          String matricule = course['matricule'];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AttendStat(
                                          course: course,
                                        ))),
                            child: CardComponent(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              margin: const EdgeInsets.only(
                                  bottom: 8, left: 18, right: 18),
                              radius: 12,
                              borderSize: 1.2,
                              borderColor: Colors.grey[400],
                              height: 80,
                              child: Row(children: [
                                CardComponent(
                                  height: 60,
                                  width: 60,
                                  radius: 60,
                                  color: Appcolors.gray,
                                  // color: flutterColors[index].withOpacity(0.8),
                                ),
                                widthSpace(20),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextComponent(
                                          text: (name),
                                          size: 16,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      TextComponent(
                                        text: (matricule),
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
