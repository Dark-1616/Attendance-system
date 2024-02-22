import 'package:attendance_system/components/constant/buttons.dart';
import 'package:attendance_system/components/colors.dart';
import 'package:attendance_system/components/constant/app_theme.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/image.dart';
import 'package:attendance_system/screen/auth/log_in.dart';
import 'package:attendance_system/screen/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAcFjDyuP2uEUHYeZR9-xDKkN3lsnYWH1w",
          appId: "1:1022929033905:android:469f3c7c7c7dfbfd186090",
          messagingSenderId: '1022929033905',
          projectId: "attendance-tracking-syst-67654"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppTheme(isDark: false)),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        ));

    // return Builder(builder: (context) {
    //   return const MaterialApp(
    //     home: MyHomePage(),
    //   );
    // });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Appcolors.white,
          body: Container(
              height: pagelength(context: context, value: 896),
              width: pagewidth(context: context, value: 414),
              child: Stack(children: [
                Positioned(
                    left: 105,
                    child: Container(
                      child: ImageWidget(
                          width: 326, heigth: 281, image: 'background2'),
                    )),
                Positioned(
                    bottom: 0,
                    right: 100,
                    child: ImageWidget(
                        width: 400, heigth: 200, image: 'background')),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              //left: pagewidth(context: context, value: 65),
                              top: pagelength(context: context, value: 70)),
                          child: ImageWidget(
                            image: 'schoologo',
                            heigth: 80,
                            width: 80,
                          )),
                      ImageWidget(
                          width: 300, heigth: 300, image: 'welcome-image'),
                      const SizedBox(
                        width: 350,
                        child: Text(
                          'Ensure your presence during courses here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Appcolors.yellow),
                        ),
                      ),
                      const SizedBox(height: 25),
                      buttonWidget(
                        action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn())),
                        child: const Center(
                            child: Text(
                          'login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        )),
                      ),
                      const SizedBox(height: 15),
                      buttonWidget(
                        action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn())),
                        color: Appcolors.white,
                        child: const Center(
                            child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Appcolors.yellow),
                        )),
                      )
                    ],
                  ),
                )
              ]))),
    );
  }
}
