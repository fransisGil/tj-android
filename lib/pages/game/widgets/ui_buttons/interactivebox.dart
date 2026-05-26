import 'package:flutter/material.dart';

Widget interactiveBox({
  required BuildContext context,
  List<Widget>? children,
  BoxDecoration? decoration,
  Key? key,
}) {
  return Flexible(
    flex: 1,
    child: Container(
      key: key,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration:
          decoration ??
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: 5,
        children: children ?? [],
      ),
    ),
  );
}
