import 'package:flutter/material.dart';

Widget pointButton({
  required BuildContext context,
  required BoxConstraints constraints,
  required String imagePath,
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
      fixedSize: Size(constraints.maxWidth * 0.3, constraints.maxHeight),
      // shape: CircleBorder(eccentricity: 0.1),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.5,
            child: Image.asset(
              imagePath,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: constraints.maxWidth * 0.045,
            ),
          ),
        ],
      ),
    ),
  );
}
