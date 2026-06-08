// Flutter packages
import 'dart:async';

import 'package:flutter/material.dart';
import '../../classes/arena.dart';
import '../setup/setup.dart';

// Modules
import '../../classes/fighter.dart';
import 'widgets/widgets.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameState();
}

class _GameState extends State<GameScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // push back to setup if current build is null
    ModalRoute.of(context)?.settings.arguments ??
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

    final Arena arena = ModalRoute.of(context)!.settings.arguments as Arena;
    Fighter red = arena.redFighter!.value;
    Fighter black = arena.blackFighter!.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertandingan ${arena.match.value} - ${arena.fight.value} - Ronde ${arena.rounds.first.value}',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.035,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 40,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SetupScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            // shape: BeveledRectangleBorder(
            //   side: BorderSide(color: Colors.black)
            // ),
            foregroundColor: Colors.black,
            // backgroundColor: Colors.black
          ),
          child: Icon(Icons.close),
          // child: Text('BALIK', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (red.sumPoints() > 0 || black.sumPoints() > 0) {
                Completer<void> completer = Completer<void>();
                showOverlay(
                  completer: completer,
                  stateSetter: setState,
                  context: context,
                  red: red,
                  black: black,
                  arena: arena,
                );
                await completer.future;
                if (arena.rounds.length == 1) {
                  if (!context.mounted) throw Exception('Context not mounted');
                  await showDialog(
                    context: context,
                    builder: (dlgContext) {
                      return AlertDialog(
                        title: Text('Pertarungan Selesai'),
                        content: Text(
                          'Pertarungan telah selesai. Halaman akan dipindah ke layar pengaturan. Jika ini tidak hendaknya terjadi, mohon dilaporkan ke panitia.',
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dlgContext);
                              Navigator.popAndPushNamed(context, '/');
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  arena.rounds.removeAt(0);
                  context.mounted
                      ? ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Berhasil')))
                      : null;
                  setState(() {});
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Data masih kosong',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              'SELESAI',
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.transparent,
        height: MediaQuery.heightOf(context),
        width: MediaQuery.widthOf(context),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8),
        child: Row(
          spacing: 10,
          children: [
            fighterInteractives(context, red, Colors.red, setState),
            fighterInteractives(context, black, Colors.black, setState),
          ],
        ),
      ),
    );
  }
}
