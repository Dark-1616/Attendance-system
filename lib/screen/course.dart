import 'package:attendance_system/components/card_component.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/components/text_component.dart';
import 'package:flutter/material.dart';

import 'attend_statistics.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final int count = 30;
    List<dynamic> Courses = [
      {"name": "Mathematics", "code": "Mth 350"},
      {"name": "Physics", "code": "Phy 200"},
      {"name": "Chemistry", "code": "Chem 101"},
      {"name": "Biology", "code": "Bio 300"},
      {"name": "Computer Science", "code": "CS 400"},
      {"name": "English Literature", "code": "Eng 220"},
      {"name": "History", "code": "Hist 150"},
      {"name": "Economics", "code": "Econ 201"},
      {"name": "Psychology", "code": "Psy 300"},
      {"name": "Sociology", "code": "Soc 250"},
      {"name": "Art History", "code": "Art 230"},
      {"name": "Political Science", "code": "PolSci 320"},
      {"name": "Geography", "code": "Geo 280"},
      {"name": "Philosophy", "code": "Phil 210"},
      {"name": "Music Theory", "code": "Musi 240"}
    ];
    List<Color> flutterColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
      Colors.lime,
      Colors.brown,
      Colors.grey,
      Colors.black,
    ];
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                          const Text(
                            'Courses',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(color: Appcolors.ligthgray),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          ImageWidget(width: 20, heigth: 20, image: 'Search')
                        ]))),
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: Courses.length,
              itemBuilder: (context, index) {
                dynamic course = Courses[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AttendStat(
                                course: course,
                              ))),
                  child: CardComponent(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin:
                        const EdgeInsets.only(bottom: 8, left: 18, right: 18),
                    radius: 12,
                    borderSize: 1.2,
                    borderColor: Colors.grey[400],
                    height: 80,
                    child: Row(children: [
                      CardComponent(
                        height: 60,
                        width: 60,
                        radius: 60,
                        color: flutterColors[index].withOpacity(0.8),
                      ),
                      widthSpace(20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextComponent(
                              text: course["name"],
                              size: 16,
                            ),
                            TextComponent(
                              text: course["code"],
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
              scrollDirection: Axis.vertical,
            )),
          ],
        ),
      ),
    );
  }
}
