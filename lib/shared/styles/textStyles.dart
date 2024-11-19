import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/shared/styles/colors.dart';

abstract class AppTextStyle {
  static TextStyle _baseFont({required TextStyle style}) {
    return GoogleFonts.roboto(textStyle: style);
  }

  static titleStyle() => _baseFont(
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      );
  static appBarStyle() => _baseFont(
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      );
  static bodyStyle() => _baseFont(
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      );
  static heading() => _baseFont(
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      );
  static subHeading() => _baseFont(
        style: const TextStyle(
          color: AppColors.notActiveColor,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        ),
      );
  static buttonTextStyle() => _baseFont(
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      );

  static subTitle() => _baseFont(
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      );
}
