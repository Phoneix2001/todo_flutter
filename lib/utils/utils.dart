import 'dart:math';

import 'package:flutter/material.dart';

// Define a set of light colors
final List<Color> lightColors = [
  Colors.pink.shade100,
  Colors.blue.shade100,
  Colors.green.shade100,
  Colors.orange.shade100,
  Colors.purple.shade100,
  Colors.yellow.shade100,
  Colors.teal.shade100,
  Colors.cyan.shade100,
];

// Pick a random light color
int get randomInteger => Random().nextInt(lightColors.length);

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

void showToast(String message) {
  ScaffoldMessenger.of(snackBarKey.currentContext!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
