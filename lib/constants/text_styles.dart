// TODO Implement this library.
import 'package:flutter/material.dart';
class KConstantColors {
  static const Color bgColor = Colors.black;
  static const Color bgColorFaint = Colors.grey;
  static const Color faintBgColor = Colors.grey; 
}
class KConstantFonts {
  static const String haskoyBold = 'Haskoy-Bold';
  static const String haskoyMedium = 'Haskoy-Medium';
}
class FontSize {
  static const double header = 24.0;
  static const double kMedium = 16.0;
}

class KCustomTextStyle {
  static TextStyle kBold(BuildContext context, double size, Color color, String fontFamily) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle kMedium(BuildContext context, double size, Color color, String fontFamily) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
    );
  }
}
