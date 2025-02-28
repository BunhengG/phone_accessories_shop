import 'package:flutter/material.dart';
import '../theme/colors_theme.dart'; // Import your color file

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: successColor,
      content: Text(
        message,
        style: const TextStyle(color: backgroundColor),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
