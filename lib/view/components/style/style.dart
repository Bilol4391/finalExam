import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style{
  Style._();

  static const primaryColo=Color(0xff613EEA);
  static const primaryColo2=Color(0x50613EEA);
  static const whiteColor=Color(0xffFFFFFF);
  static const primaryColor=Color(0xff000000);
  static const blackColor2=Color(0x90000000);

  static const greyColor=Color(0xffE4E4EF);
  static const syncColor=Color(0xff3AF9EF);
  static const greenColor=Color(0xff10A968);
  static const redColor=Color(0xfff60000);


  static const linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
      Color(0xff000000),
        Color(0x67000000),
        Color(0x87000000),
        Color(0x76000000),
        Color(0x86000000),
      ]);

  set backgroundGradientColor(LinearGradient backgroundGradientColor) {}

static LinearGradient customGeadient({Color color=Style.primaryColor})=>
  LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
    color.withOpacity(1),
    color.withOpacity(0.66),
    color.withOpacity(0.87),
    color.withOpacity(0.76),
    color.withOpacity(0.86)
  ]);



  static TextStyle primaryText(
      {double size = 24,FontWeight weight=FontWeight.w500, Color textColor = Style.primaryColor,}) =>
      GoogleFonts.sarabun(
          fontWeight: weight,
          color: textColor,
          fontSize: size
      );
}