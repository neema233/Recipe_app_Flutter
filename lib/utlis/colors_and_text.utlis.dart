import 'package:flutter/material.dart';

abstract class ColorsConst {
  static const int mainColor = 0xFFF55A00;
  static const int containerBackgroundColor = 0xFFB2B7C6;
  static const int titleColor = 0xFF128FAE;
  static const int fillColor = 0xFFF7F8Fc;
}

abstract class StyleCons {
  static const TextStyle sectionText = TextStyle(
      fontFamily: "Hellix", fontWeight: FontWeight.w800, fontSize: 18);
  static const TextStyle choicesText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Color(ColorsConst.mainColor)); //see all ,home,menu
  static const TextStyle caloriesText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w400,
      fontSize: 8,
      color: Color(ColorsConst.mainColor));
  static const TextStyle dishTypeText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w500,
      fontSize: 8,
      color: Color(ColorsConst.titleColor)); //breackfast,dinner...
  static const TextStyle dishNameText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black);
  static const TextStyle serviceText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w400,
      fontSize: 8,
      color: Color(ColorsConst.containerBackgroundColor));
  static const TextStyle searchText = TextStyle(
      fontFamily: "Hellix",
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color(ColorsConst.containerBackgroundColor));
  static const TextStyle introText = TextStyle(
      fontFamily: "AbrilFatface",
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black);
}
