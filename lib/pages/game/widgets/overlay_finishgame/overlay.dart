import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pertarungan/classes/arena.dart';
import 'package:pertarungan/classes/fighter.dart';

OverlayState showOverlay({
  required BuildContext context,
  required Arena arena,
  required Fighter red,
  required Fighter black,
  required void Function(void Function()) stateSetter,
  required Completer completer
}) {
  OverlayState overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  bool isLoading = false;
  final screenWidth = MediaQuery.sizeOf(context).width;

  void processRequest({required Future<void> Function() process}) async {
    try {
      isLoading = true;
      overlayEntry.remove();
      overlayState.insert(overlayEntry);
      await process();
    } catch (e) {
      context.mounted
          ? ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error encountered: $e')))
          : null;
    } finally {
      overlayEntry.remove();
      completer.complete();
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
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        processRequest(
                          process: () async {
                            // TODO: Tarungan Selesai; normal finish condition
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxWidth * 0.045,
                        ),
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
                            'WHT: Merah Menang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth * 0.045,
                            ),
                          ),
                        ),
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
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            'WHT: Hitam Menang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => overlayEntry.remove(),
                      style: TextButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text(
                        'BATAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ),
  );
  overlayState.insert(overlayEntry);
  return overlayState;
}
