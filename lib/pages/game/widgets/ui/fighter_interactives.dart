import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'interactivebox.dart';
import '../../../../../classes/fighter.dart';

StatefulWidget fighterInteractives(
  BuildContext context,
  Fighter side,
  Color color,
) {
  return StatefulBuilder(
    builder: (parentConstraints, setState) => Expanded(
      child: LayoutBuilder(
        builder: (layoutCtx, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: 10,
          children: [
            Text(
              '${side.sumPoints()}',
              style: TextStyle(
                fontFamily: "",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            fighterPunchInteractives(constraints, side, color, setState),
            fighterKickInteractives(constraints, side, color, setState),
            fighterPenaltiesInteractives(constraints, side, color, setState),
          ],
        ),
      ),
    ),
  );
}

Widget fighterPenaltiesInteractives(
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  double fontSize = 64;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: LayoutBuilder(
      builder: (ctx, constraints) => Column(
        spacing: 5,
        children: [
          Text('Pelanggaran', style: TextStyle(fontSize: fontSize - 6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              TextButton(
                onPressed: () {
                  side.penalties.addBerat();
                  updateState(() => side);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 207, 31, 18),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text('BERAT', style: TextStyle(color: Colors.white, fontSize: fontSize)),
              ),
              TextButton(
                onPressed: () {
                  side.penalties.addRingan();
                  updateState(() => side);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 207, 31, 18),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Text('RINGAN', style: TextStyle(color: Colors.white, fontSize: fontSize)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget fighterKickInteractives(
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  return interactiveBox(
    color: color,
    titleIcon: Symbols.sports_martial_arts,
    titleString: 'TENDANGAN',
    faceAction: () {
      side.kick.addMuka();
      updateState(() {});
    },
    bodyAction: () {
      side.kick.addBadan();
      updateState(() {});
    },
    goyahAction: () {
      side.kick.addGoyah();
      updateState(() {});
    },
  );
}

Widget fighterPunchInteractives(
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  return interactiveBox(
    color: color,
    titleIcon: Symbols.sports_mma,
    titleString: 'PUKULAN',
    faceAction: () {
      side.punch.addMuka();
      updateState(() => side);
    },
    bodyAction: () {
      side.punch.addBadan();
      updateState(() => side);
    },
    goyahAction: () {
      side.punch.addGoyah();
      updateState(() => side);
    },
  );
}
