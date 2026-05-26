// Flutter packages
import 'package:flutter/material.dart';
import '../../../../classes/arena.dart';
import '../setup/setup.dart';

// Modules
import '../../classes/fighter.dart';
import 'components/widgets/widgets.dart';

class GameScreen extends StatefulWidget {
  final Arena? arena;
  const GameScreen({super.key, this.arena});

  @override
  State<GameScreen> createState() => _GameState();
}

class _GameState extends State<GameScreen> with SingleTickerProviderStateMixin {
  void _showOverlay({
    required BuildContext context,
    required Fighter red,
    required Fighter black,
  }) {
    OverlayState overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    bool isLoading = false;
    final screenWidth = MediaQuery.sizeOf(context).width;


    void processRequest({required Future<void> Function() process}) async {
      try {
        setState(() {
          isLoading = true;
          overlayEntry.remove();
          overlayState.insert(overlayEntry);
        });
        await process();
        context.mounted
            ? ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Berhasil')))
            : null;
      } catch (e) {
        context.mounted
            ? ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error encountered: $e')))
            : null;
      } finally {
        overlayEntry.remove();
        setState(() {});
      }
    }

    overlayEntry = OverlayEntry(
      opaque: false,
      maintainState: false,
      builder: (context) => Container(
        color: Colors.grey.withAlpha(200),
        child: isLoading
            ? SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Text(
                      'Memuat...',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.widthOf(context) * 0.3,
                      width: MediaQuery.widthOf(context) * 0.3,
                      child: CircularProgressIndicator(strokeWidth: 6),
                    ),
                  ],
                ),
              )
            : TapRegion(
                onTapOutside: (event) => overlayEntry.remove(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // spacing: 50,
                  children: [
                    TextButton(
                      onPressed: () {
                        processRequest(
                          process: () async {
                            await Future.delayed(Duration(seconds: 5));
                            red.resetPoints();
                            black.resetPoints();
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'TARUNGAN SELESAI',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: screenWidth * 0.1,
                      children: [
                        TextButton(
                          onPressed: () {
                            processRequest(
                              process: () async {
                                await Future.delayed(Duration(seconds: 5));
                                red.resetPoints();
                                black.resetPoints();
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red.shade900,
                          ),
                          child: Text(
                            'WHT',
                            style: TextStyle(color: Colors.white, fontSize: 32),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            processRequest(
                              process: () async {
                                await Future.delayed(Duration(seconds: 5));
                                black.points = 0;
                                red.resetPoints();
                                black.resetPoints();
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            'WHT',
                            style: TextStyle(color: Colors.white, fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text(
                        'BATAL',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
    overlayState.insert(overlayEntry);
  }

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
                _showOverlay(context: context, black: black, red: red);
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
