import 'package:flutter/material.dart';

Color colorRGB(int r, int g, int b) {
  return Color.fromARGB(255, r, g, b);
}

Widget buildLinearGradient(
        Color from, Color to, AlignmentGeometry start, AlignmentGeometry end) =>
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [from, to], begin: start, end: end)),
    );
