// Flutter packages
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
    // try {
    //   widget.arena;
    // } catch (e) {
    //   Navigator.popAndPushNamed(context, '/setup');
    // }
    // Arena? arena = widget.arena;
    // Fighter red = arena!.redFighter;
    // Fighter black = arena.blackFighter;

    Arena arena = Arena(match: "Demo", fight: "Petarungan Demo", judge: "Juri Demo", rounds: [1, 2]  );
    Fighter red = arena.redFighter;
    Fighter black = arena.blackFighter;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertandingan ${arena.match} - ${arena.fight} - Ronde ${arena.rounds[0]} - Juri ${arena.judge}',
          style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.035, fontWeight: FontWeight.bold),
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
          child: Icon(Icons.close)
          // child: Text('BALIK', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (red.sumPoints() > 0 || black.sumPoints() > 0) {
                showOverlay(context: context, red: red, black: black);
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
            style: TextButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
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
            fighterInteractives(
              context,
              red,
              Colors.red
            ),
            fighterInteractives(
              context,
              black,
              Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
