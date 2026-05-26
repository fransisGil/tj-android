// Flutter packages
import 'package:flutter/material.dart';
import '../../classes/arena.dart';
import '../setup/setup.dart';

// Modules
import '../../classes/fighter.dart';
import 'widgets/widgets.dart';

class GameScreen extends StatefulWidget {
  final Arena? arena;
  const GameScreen({super.key, this.arena});

  @override
  State<GameScreen> createState() => _GameState();
}

class _GameState extends State<GameScreen> with SingleTickerProviderStateMixin {
  

  final GlobalKey<_GameState> key = GlobalKey<_GameState>();
  void updatePoints(int points, Fighter side) {
    setState(() {
      side.points = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.arena;
    } catch (e) {
      Navigator.popAndPushNamed(context, '/setup');
    }
    Arena? arena = widget.arena;
    Fighter red = arena!.redFighter;
    Fighter black = arena.blackFighter;

    double screenHeight = MediaQuery.heightOf(context);
    double screenWidth = MediaQuery.widthOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pertarungan ${arena.location} - Arena ${arena.arena} - Round ${arena.matches[0]} - Juri ${arena.judge}',
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SetupScreen()),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: Text('BALIK', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (red.points > 0 || black.points > 0) {
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
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'SELESAI',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.transparent,
        height: screenHeight,
        width: screenWidth,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            fighterInteractives(
              context,
              red,
              Colors.red,
              (points) => updatePoints(points, red),
            ),
            fighterInteractives(
              context,
              black,
              Colors.black,
              (points) => updatePoints(points, black),
            ),
          ],
        ),
      ),
    );
  }
}
