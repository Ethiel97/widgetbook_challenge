import 'package:flutter/material.dart';

///extensions for snackbar
extension SnackUtils on BuildContext {
  ///custom extension method to show snack
  void showSnack(
    String message, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    backgroundColor ??= Theme.of(this).colorScheme.primary;
    textColor ??= Theme.of(this).colorScheme.inversePrimary;
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(
            seconds: 2,
          ),
          content: Text(
            message,
            style: TextStyle(
              color: textColor,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
      );
  }
}
