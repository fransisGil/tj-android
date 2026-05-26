import 'package:flutter/material.dart';
import 'package:pertarungan/classes/fighter.dart';

OverlayState showOverlay({
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
      isLoading = true;
      overlayEntry.remove();
      overlayState.insert(overlayEntry);
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
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
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
  return overlayState;
}
