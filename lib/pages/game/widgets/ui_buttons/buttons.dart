import 'package:flutter/material.dart';
import '../../../../../classes/fighter.dart';

Widget pointButton({required BuildContext context, required IconData icon, required Fighter side, required Color? color, required VoidCallback action}) {
  return IconButton(
    onPressed: action,
    icon: Icon(icon, color: Colors.white, size: MediaQuery.sizeOf(context).height * 0.05),
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
  );
}