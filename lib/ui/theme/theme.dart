// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/colors.dart';

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

final ThemeData LightTheme = ThemeData(
  primarySwatch: _createMaterialColor(AppColor.primaryColor),
  primaryColor: AppColor.primaryColor,
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 24, fontWeight: FontWeight.w600),
    displayMedium: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 20, fontWeight: FontWeight.w500),
    displaySmall: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 18, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.montserrat(
        color: Color(0xFF3C3C3C), fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.montserrat(
        color: Color(0xFF3C3C3C), fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.montserrat(
        color: Color(0xFF3C3C3C), fontSize: 12, fontWeight: FontWeight.w300),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    foregroundColor: Color(0xFF3C3C3C),
    titleTextStyle: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 16, fontWeight: FontWeight.w600),
    centerTitle: true,
    elevation: 0.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white54;
          }
          return Colors.white;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.primaryColor.withOpacity(0.5);
          }
          return AppColor.primaryColor;
        },
      ),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: 16.0,
                fontWeight: FontWeight.w600);
          }
          return GoogleFonts.poppins(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);
        },
      ),
      padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.zero),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      minimumSize: WidgetStateProperty.all(Size(double.infinity, 60.0)),
      elevation: WidgetStateProperty.all(0.0),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 19.6,
          horizontal: 15.0), // Adjusting padding to match the design
      filled: true,
      fillColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 0.79992),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(
      AppColor.primaryColor,
    ),
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
          color: AppColor.primaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    side: WidgetStateProperty.all(
      BorderSide(
        color: AppColor.primaryColor,
      ),
    ),
    padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.zero),
    minimumSize: WidgetStateProperty.all(Size(double.infinity, 60.0)),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: AppColor.primaryColor,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 18, fontWeight: FontWeight.w600),
    contentTextStyle: GoogleFonts.poppins(
        color: Color(0xFF3C3C3C), fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0.0),
      foregroundColor: WidgetStateProperty.all(
        AppColor.primaryColor,
      ),
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
);

final ThemeData DarkTheme = ThemeData(
  primarySwatch: _createMaterialColor(AppColor.primaryColor),
  primaryColor: AppColor.primaryColor,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 24, fontWeight: FontWeight.w600),
    displayMedium: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 20, fontWeight: FontWeight.w500),
    displaySmall: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 18, fontWeight: FontWeight.w400),
    headlineLarge: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 24, fontWeight: FontWeight.w600),
    headlineMedium: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: GoogleFonts.montserrat(
        color: Color(0xFFE3E3E3), fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.montserrat(
        color: Color(0xFFE3E3E3), fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.montserrat(
        color: Color(0xFFE3E3E3), fontSize: 12, fontWeight: FontWeight.w500),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFFE3E3E3),
    titleTextStyle: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 16, fontWeight: FontWeight.w600),
    centerTitle: true,
    elevation: 0.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white54;
          }
          return Colors.white;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColor.primaryColor.withOpacity(0.5);
          }
          return AppColor.primaryColor;
        },
      ),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: 16.0,
                fontWeight: FontWeight.w600);
          }
          return GoogleFonts.poppins(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);
        },
      ),
      padding: WidgetStateProperty.resolveWith((states) => EdgeInsets.zero),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      minimumSize: WidgetStateProperty.all(Size(double.infinity, 60.0)),
      elevation: WidgetStateProperty.all(0.0),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(
      Colors.white,
    ),
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    side: WidgetStateProperty.all(
      BorderSide(
        color: AppColor.primaryColor,
      ),
    ),
    minimumSize: WidgetStateProperty.all(Size(double.infinity, 50.0)),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: AppColor.primaryColor,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF0C0C0C),
    titleTextStyle: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 18, fontWeight: FontWeight.w600),
    contentTextStyle: GoogleFonts.poppins(
        color: Color(0xFFE3E3E3), fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0.0),
      foregroundColor: WidgetStateProperty.all(
        AppColor.primaryColor,
      ),
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      textStyle: WidgetStateProperty.all(
        GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  ),
  scaffoldBackgroundColor: AppColor.primaryColor,
);
