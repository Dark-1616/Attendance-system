import 'package:flutter/material.dart';

import '../components/colors.dart';
import '../components/image.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageWidget(width: 414, heigth: 407, image: 'Rectangle'),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 40,
                          width: 44,
                          decoration: BoxDecoration(
                              color: Appcolors.deepyellow,
                              borderRadius: BorderRadius.circular(12)),
                          child: ImageWidget(
                              width: 23, heigth: 24, image: 'Arrow')),
                      Container(
                          height: 40,
                          width: 44,
                          decoration: BoxDecoration(
                              color: Appcolors.deepyellow,
                              borderRadius: BorderRadius.circular(12)),
                          child: ImageWidget(
                              width: 23, heigth: 24, image: 'settings'))
                    ]),
                const SizedBox(height: 60),
                const Text(
                  'Mathematics',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'mth 350',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}
