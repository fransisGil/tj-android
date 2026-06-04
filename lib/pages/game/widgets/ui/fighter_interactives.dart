import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'interactivebox.dart';
import '../../../../../classes/fighter.dart';

Widget fighterInteractives(
  BuildContext context,
  Fighter side,
  Color color,
  void Function(void Function()) stateSetter
) {
  return Expanded(
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
              fontSize: MediaQuery.of(context).size.height * 0.05,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          fighterPunchInteractives(layoutCtx, constraints, side, color, stateSetter),
          fighterKickInteractives(layoutCtx, constraints, side, color, stateSetter),
          fighterPenaltiesInteractives(layoutCtx, constraints, side, color, stateSetter),
        ],
      ),
    ),
  );
}

Widget fighterPenaltiesInteractives(
  BuildContext ctx,
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  double fontSize = MediaQuery.of(ctx).size.height * 0.05;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: LayoutBuilder(
      builder: (ctx, constraints) => Column(
        spacing: 5,
        children: [
          Text(
            'Pelanggaran',
            style: TextStyle(fontSize: fontSize - 6, fontWeight: FontWeight.bold),
          ),
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
                child: Text(
                  'BERAT',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
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
                child: Text(
                  'RINGAN',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget fighterKickInteractives(
  BuildContext ctx,
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  return interactiveBox(
    context: ctx,
    color: color,
    titleIcon: Symbols.sports_martial_arts,
    titleString: 'TENDANGAN',
    faceAction: () {
      side.kick.addMuka();
      updateState(() => side);
    },
    bodyAction: () {
      side.kick.addBadan();
      updateState(() => side);
    },
    goyahAction: () {
      side.kick.addGoyah();
      updateState(() => side);
    },
  );
}

Widget fighterPunchInteractives(
  BuildContext ctx,
  BoxConstraints parentConstraints,
  Fighter side,
  Color color,
  StateSetter updateState,
) {
  return interactiveBox(
    context: ctx,
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
