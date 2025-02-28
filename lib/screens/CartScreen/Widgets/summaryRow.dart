import 'package:flutter/material.dart';

import '../../../theme/text_theme.dart';

Widget buildSummaryRow(String label, double amount) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.getSIMISubtitleSize(),
        ),
        Text("\$${amount.toStringAsFixed(2)}",
            style: AppTextStyles.getSubtitleSize()),
      ],
    ),
  );
}
