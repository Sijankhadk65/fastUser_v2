import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSettings {
  static TextStyle _titleSmallFontStyleLight = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
    fontSize: 17,
  );
  static TextStyle _titleSmallFontStyleDark = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
    fontSize: 17,
    color: Colors.white,
  );
  static TextStyle _titleExtraLargeFontStyleLight = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
    fontSize: 35,
  );
  static TextStyle _titleExtraLargeFontStyleDark = GoogleFonts.nunito(
    fontWeight: FontWeight.w800,
    fontSize: 35,
    color: Colors.white,
  );
  static TextStyle _descriptionSmallFontStyleLight = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Colors.black45,
  );
  static TextStyle _descriptionSmallFontStyleDark = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Colors.white70,
  );
  static TextStyle _descriptionLargeFontStyleLight = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: Colors.black45,
  );
  static TextStyle _descriptionLargeFontStyleDark = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: Colors.white70,
  );
  static TextStyle TitleStyleSmallLight() {
    return _titleSmallFontStyleLight;
  }

  static TextStyle TitleStyleSmallDark() {
    return _titleSmallFontStyleDark;
  }

  static TextStyle TitleStyleExtraLargeLight() {
    return _titleExtraLargeFontStyleLight;
  }

  static TextStyle TitleStyleExtraLargeDark() {
    return _titleExtraLargeFontStyleDark;
  }

  static TextStyle DescriptionStyleSmallLight() {
    return _descriptionSmallFontStyleLight;
  }

  static TextStyle DescriptionStyleSmallDark() {
    return _descriptionSmallFontStyleDark;
  }

  static TextStyle DescriptionStyleLargeLight() {
    return _descriptionLargeFontStyleLight;
  }

  static TextStyle DescriptionStyleLargeDark() {
    return _descriptionLargeFontStyleDark;
  }
}
