import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  bool darkMode = false;

  Color borderLight = Colors.grey.shade300;
  Color borderDark = const Color(0xFF334A5C);

  Color lightPrimary = Colors.white;
  Color darkPrimary = const Color(0xFF1C2832);

  Color lightSecondary = Colors.white;
  Color darkSecondary = const Color(0xFF1C2832);

  Color get border => darkMode ? borderDark : borderLight;

  Color get primary => darkMode ? darkPrimary : lightPrimary;
  Color get secondary => darkMode ? darkSecondary : lightSecondary;

  //BIG VARIABLE FOR APP THEME
  late Color currentTheme;
  late Color currentThemeSecondary;
  late Color primaryFontColor;
  late Color secondaryFontColor;

  AppTheme({required bool isDark}) {
    setCurrentAppThemeAndFontColor(isDark);
  }

  //THEME OF APP
  Color lightTheme = Colors.white;
Color lightThemeSecondary = Colors.white; //Colors.grey.shade200;
  Color darkTheme = const Color(0xFF131c23);
  Color darkThemeSecondary = const Color(0xFF1f2c34);

  Color darkThemeSecondary2 = const Color.fromARGB(255, 38, 55, 66);

  //PRIMATY COLOR OF FONT WITH CURRENT THEME
  Color lightPrimaryFontColor = Colors.white;
  Color darkPrimaryFontColor = Colors.black;

  //SECONDARY COLOR OF FONT WITH CURRENT THE
  Color lightSecondaryFontColor = Colors.white.withOpacity(0.5);
  Color darkSecondaryFontColor = Colors.black.withOpacity(0.5);

  //GET THEME COLOR AND FONTS COLORS
  Color get getTheme => currentTheme;
  Color get getThemeSecondary => currentThemeSecondary;
  Color get getPrimaryFontColor => primaryFontColor;
  Color get getSecondaryFontColor => secondaryFontColor;

  //SET FONT AND THEME COLOR FOR CURRENT THEME OF APP
  void setCurrentAppThemeAndFontColor(bool isDark) async {
    darkMode = isDark;
    currentTheme = isDark ? darkTheme : lightTheme;
    currentThemeSecondary = isDark ? darkThemeSecondary : lightThemeSecondary;
    primaryFontColor = isDark ? lightPrimaryFontColor : darkPrimaryFontColor;
    secondaryFontColor =
        isDark ? lightSecondaryFontColor : darkSecondaryFontColor;

   

    notifyListeners();
  }


  void changeAppTheme([bool? notify]) async {
    darkMode = (currentTheme == lightTheme) ? true : false;
    currentTheme = (currentTheme == lightTheme) ? darkTheme : lightTheme;
    currentThemeSecondary = (currentThemeSecondary == lightThemeSecondary)
        ? darkThemeSecondary
        : lightThemeSecondary;
    primaryFontColor = (currentTheme == lightTheme)
        ? darkPrimaryFontColor
        : lightPrimaryFontColor;
    secondaryFontColor = (currentTheme == lightTheme)
        ? darkSecondaryFontColor
        : lightSecondaryFontColor;


    if (notify == null) {
      //NOTIFY ALL PAGE CONSUME THIS PROVIDER TO MAKE UPDATE
      notifyListeners();
    }
  }

  void resetAppTheme() async {
    currentTheme = lightTheme;
    currentThemeSecondary = lightThemeSecondary;
    primaryFontColor = lightPrimaryFontColor;
    secondaryFontColor = lightSecondaryFontColor;

 
  }

  //THEME FOR AUTH SCREEN
 

  Color get background =>
      currentTheme == darkTheme ? getTheme : const Color(0xFFF4F4F4);
}
