import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'buttons.dart';
import '../../../../../classes/fighter.dart';
import 'button_box.dart';


Widget fighterInteractives(BuildContext context, Fighter side, Color color, ValueSetter<int> updateState) {
  return Expanded(
    flex: 1,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      spacing: 5,
      children: [
        Text('${side.points}', style: TextStyle(fontFamily: "", fontSize: 30, fontWeight: FontWeight.bold, color: color)),
        fighterPunchInteractives(context, side, color, updateState ),
        fighterKickInteractives(context, side, color, updateState),
        fighterPenaltiesInteractives(context, side, color, updateState ),
      ],
    ),
  );
}

Column fighterPenaltiesInteractives(
  BuildContext context,
  Fighter side,
  Color color,
  ValueSetter<int> updateState,
) {
  return Column(
    spacing: 5,
    children: [
      Text('Pelanggaran', style: TextStyle(fontSize: 18)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          TextButton(
            onPressed: () {
              side.removePoints(2);
              updateState(side.points);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                const Color.fromARGB(255, 207, 31, 18),
              ),
            ),
            child: Text(
              'BERAT',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.textScalerOf(context).scale(30),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              side.removePoints(1);
              updateState(side.points);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                const Color.fromARGB(255, 207, 31, 18),
              ),
            ),
            child: Text(
              'RINGAN',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ],
      ),
    ],
  );
}

Container fighterKickInteractives(
  BuildContext context,
  Fighter side,
  Color color,
  ValueSetter<int> updateState,
) {
  return interactiveBox(
    context: context,
    decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
    children: [
      Row(
        children: [
          Icon(Symbols.sports_martial_arts, color: color),
          Text('TENDANGAN', style: TextStyle(fontSize: 18)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Muka
          pointButton(
            context: context,
            icon: Symbols.cognition_2,
            side: side,
            color: color,
            action: () {
              side.addPoints(3);
              updateState(side.points);
            },
          ),
          // Badan
          pointButton(
            context: context,
            icon: Symbols.rib_cage,
            side: side,
            color: color,
            action: () {
              side.addPoints(2);
              updateState(side.points);
            },
          ),
          // Goyah
          pointButton(
            context: context,
            icon: Symbols.falling,
            side: side,
            color: color,
            action: () {
              side.addPoints(4);
              updateState(side.points);
            },
          ),
        ],
      ),
    ],
  );
}

Container fighterPunchInteractives(
  BuildContext context,
  Fighter side,
  Color color, ValueSetter<int> updateState ,
) {
  return interactiveBox(
    context: context,
    decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
    children: [
      Row(
        children: [
          Icon(Symbols.sports_mma, color: color),
          Text('PUKULAN', style: TextStyle(fontSize: 18)),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Muka
          pointButton(
            context: context,
            icon: Symbols.cognition,
            side: side,
            color: color,
            action: () {
              side.addPoints(2);
              updateState(side.points);
            },
          ),
          // Badan
          pointButton(
            context: context,
            icon: Symbols.rib_cage,
            side: side,
            color: color,
            action: () {
              side.addPoints(1);
              updateState(side.points);
            },
          ),
          // Goyah
          pointButton(
            context: context,
            icon: Symbols.falling,
            side: side,
            color: color,
            action: () {
              side.addPoints(3);
              updateState(side.points);
            },
          ),
        ],
      ),
    ],
  );
}