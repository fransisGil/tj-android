import 'package:flutter/material.dart';

Widget pointButton({
  required BoxConstraints constraints,
  required IconData icon,
  required Color color,
  required VoidCallback action,
}) {
  return IconButton(
    onPressed: action,
    icon: Icon(icon, color: Colors.white),
    style: IconButton.styleFrom(
      backgroundColor: color,
      alignment: AlignmentGeometry.center,
      focusColor: Colors.white,
      overlayColor: Colors.white,
      hoverColor: Colors.white38,
    ),
    iconSize: constraints.maxWidth / 3 - 20,
  );
}
