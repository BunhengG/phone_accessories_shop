import 'package:flutter/material.dart';

// Define a Map of color names to their corresponding hex values
final Map<String, Color> colorMap = {
  'pink': const Color(0xFFFFC0CB), // pink
  'gold': const Color(0xFFFFB200), // gold
  'blue': const Color(0xFF0000FF), // blue
  'white': const Color(0xFFFFFFFF), // white
  'black': const Color(0xFF000000), // black
  'silver': const Color(0xFFC0C0C0), // silver
  'yellow': const Color(0xFFECE852), // yellow
  'orange': const Color(0xFFE9762B), // orange
};

Color getColorFromString(String colorName) {
  return colorMap[colorName.toLowerCase()] ?? Colors.transparent;
}
