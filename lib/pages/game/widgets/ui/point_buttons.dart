import 'package:flutter/material.dart';

Widget pointButton({
  required BuildContext context,
  required BoxConstraints constraints,
  required IconData icon,
  required Color color,
  required VoidCallback action,
  required String label,
}) {
  return ElevatedButton(
    onPressed: action,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      alignment: AlignmentGeometry.center,
      overlayColor: Colors.white,
      fixedSize: Size(constraints.maxWidth * 0.25, constraints.maxHeight * 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: constraints.maxHeight * 0.5,),
        Text(label, style: TextStyle(color: Colors.white, fontSize: constraints.maxWidth * 0.05),)
      ],
    )
  );
}
