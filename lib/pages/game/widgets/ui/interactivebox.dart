import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pertarungan/pages/game/widgets/ui/point_buttons.dart';

Widget interactiveBox({
  required String titleString,
  required IconData titleIcon,
  required void Function() faceAction,
  required void Function() bodyAction,
  required void Function() goyahAction,
  Color? color,
}) {
  color ?? Colors.black;
  return Flexible(
    flex: 1,
    child: Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: color!, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: 5,
        children: [
          Row(
            children: [
              Icon(titleIcon, color: color, size: 64,),
              Text(titleString, style: TextStyle(color: color, fontSize: 26),)
            ]),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Muka
                  pointButton(
                    constraints: constraints,
                    icon: Symbols.cognition_2,
                    color: color,
                    action: faceAction,
                  ),
                  // Badan
                  pointButton(
                    constraints: constraints,
                    icon: Symbols.rib_cage,
                    color: color,
                    action: bodyAction,
                  ),
                  // Goyah
                  pointButton(
                    constraints: constraints,
                    icon: Symbols.falling,
                    color: color,
                    action: goyahAction,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
