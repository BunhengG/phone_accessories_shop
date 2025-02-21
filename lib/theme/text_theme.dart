import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_accessories_shop/theme/colors_theme.dart';

class AppTextStyles {
  // Extra TITLE
  static TextStyle getExtraTitleSize() {
    return GoogleFonts.nunito(
      fontSize: 32,
      height: 1.33,
      fontWeight: FontWeight.w900,
      color: titleColor,
    );
  }

  // TITLE
  static TextStyle getTitleSize() {
    return GoogleFonts.nunito(
      fontSize: 24,
      height: 0.85,
      fontWeight: FontWeight.w800,
      color: titleColor,
    );
  }

  // SUBTITLE
  static TextStyle getSubtitleSize() {
    return GoogleFonts.nunito(
      fontSize: 16,
      height: 0.8,
      fontWeight: FontWeight.w700,
      color: bodyColor,
    );
  }

  // SIMI_SUBTITLE
  static TextStyle getSIMISubtitleSize() {
    return GoogleFonts.nunito(
      fontSize: 14,
      height: 0.87,
      fontWeight: FontWeight.w600,
      color: bodyColor,
    );
  }

  // BODY
  static TextStyle getBodySize() {
    return GoogleFonts.nunito(
      fontSize: 12,
      height: 1,
      fontWeight: FontWeight.w500,
      color: bodyColor,
    );
  }

  // placeholder
  static TextStyle getPlaceholderSize() {
    return GoogleFonts.nunito(
      fontSize: 10,
      height: 1,
      fontWeight: FontWeight.w400,
      color: placeholderColor,
    );
  }

  // Text Button
  static TextStyle getTextButtonSize() {
    return GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: backgroundColor,
    );
  }
}
