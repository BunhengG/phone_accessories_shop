import 'package:flutter/material.dart';

class AppShadows {
  // MEDIUM SHADOW
  static List<BoxShadow> getMediumShadow() {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, -1),
      ),
    ];
  }
}
