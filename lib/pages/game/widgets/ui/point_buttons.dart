import 'package:flutter/material.dart';

Widget pointButton({
  required BoxConstraints constraints,
  required IconData icon,
  required Color color,
  required VoidCallback action,
}) {
  return Expanded(
    child: IconButton(
      onPressed: action,
      icon: Icon(icon, color: Colors.white, size: constraints.maxHeight * 0.8,),
      style: IconButton.styleFrom(
        backgroundColor: color,
        alignment: AlignmentGeometry.center,
        focusColor: Colors.white,
        overlayColor: Colors.white,
        hoverColor: Colors.white38,
      ),
      
      iconSize: constraints.maxHeight
    ),
  );
}
