import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/palletes.dart';

class CustomTheme {
  static final ThemeData light = ThemeData(
      primaryColor: kPrimaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        fixedSize: const Size(double.maxFinite, 50),
        backgroundColor: kPrimaryColor,
      )),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.grey[300],
        hintStyle: GoogleFonts.roboto(fontSize: 12, color: kLightGreyColor),
        labelStyle: GoogleFonts.roboto(fontSize: 12, color: kDarkGreyColor),
        contentPadding:
            const EdgeInsetsDirectional.symmetric(vertical: 1, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: kLightGreyColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: kDarkGreyColor)),
        focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[100]!)),
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.chewy(fontSize: 30, color: Colors.yellow[700]),
        labelLarge: GoogleFonts.roboto(fontSize: 18, color: kDarkGreyColor),
        labelMedium: GoogleFonts.roboto(fontSize: 14, color: kDarkGreyColor),
        labelSmall: GoogleFonts.roboto(fontSize: 12, color: kDarkGreyColor),
        displaySmall:
            GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold),
        displayMedium:
            GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
        titleSmall:
            GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        titleMedium:
            GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        titleLarge:
            GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.bold),
      ));
}