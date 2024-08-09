import 'package:flutter/material.dart';

class ColoredToast {
  static void show(BuildContext context, String message, bool isSuccess) {
    final backgroundColor = isSuccess ? Colors.green : Colors.red;
    final textColor = Colors.white;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3), // Adjust duration as needed
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        behavior: SnackBarBehavior.floating, // Ensures visibility on top
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
    );
  }
}
