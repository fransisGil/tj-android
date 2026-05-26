import 'package:flutter/material.dart';
import '../../classes/arena.dart';
import '../../pages/game/game.dart';

Map<String, Map<String, dynamic>> events = {
  'location 1': {
    'ring': <String, List<String>>{
      'Arena 1': ['Game 1', 'Game 2', 'Game 3'],
      'Arena 2': ['Game 1', 'Game 2', 'Game 3'],
      'Arena 3': ['Game 1', 'Game 2', 'Game 3'],
    },
    'judge': <String>['Judge 1', 'Judge 2', 'Judge 3'],
  },
};

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupState();
}

class _SetupState extends State<SetupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ringController = TextEditingController();
  final TextEditingController _judgeController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    _ringController.dispose();
    _judgeController.dispose();
    super.dispose();
  }

  List<String>? matches;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await Future.delayed(Duration(seconds: 5));
          setState(() {
            isLoading = false;
          });
        },
        style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
        child: Icon(Icons.refresh),
      ),
      body: Center(
        heightFactor: MediaQuery.heightOf(context),
        widthFactor: MediaQuery.widthOf(context),
        child: Card(
          // margin: EdgeInsets.all(MediaQuery.widthOf(context) * 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 20,
            children: [
              Text(
                'Pengaturan\n',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Lokasi: '),
                  dataDropdownMenu(
                    controller: _locationController,
                    entries: events.entries
                        .map(
                          (entry) => DropdownMenuEntry(
                            value: entry.key,
                            label: entry.key,
                          ),
                        )
                        .toList(),
                  ),
                  Text('Ring: '),
                  dataDropdownMenu(
                    enabled: _locationController.text.isNotEmpty,
                    controller: _ringController,
                    entries: _locationController.text.isEmpty
                        ? []
                        : ((events[_locationController.text]!['ring']
                                      as Map<String, List<String>>)
                                  .keys
                                  .map(
                                    (ring) => DropdownMenuEntry<String>(
                                      value: ring,
                                      label: ring,
                                    ),
                                  ))
                              .toList(),
                    selectAction: (value) {
                      matches = events[_locationController.text]!['ring'][_ringController.text];
                      setState(() {
                        
                      });
                    },
                  ),
                  Text('Juri: '),
                  dataDropdownMenu(
                    enabled: _locationController.text.isNotEmpty,
                    controller: _judgeController,
                    entries: _locationController.text.isEmpty
                        ? []
                        : (events[_locationController.text]!['judge']
                                  as List<String>)
                              .map(
                                (judge) => DropdownMenuEntry(
                                  value: judge,
                                  label: judge,
                                ),
                              )
                              .toList(),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_locationController.text.isEmpty ||
                      _ringController.text.isEmpty ||
                      _judgeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Semua field harus diisi!')),
                    );
                    return;
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        arena: Arena(
                          arena: _ringController.text,
                          judge: _judgeController.text,
                          location: _locationController.text,
                          matches: matches!,
                        ),
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Masuk',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataDropdownMenu({
    required TextEditingController controller,
    required List<DropdownMenuEntry<String>> entries,
    ValueChanged<String?>? selectAction,
    bool? enabled,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: controller.text.isEmpty ? '' : controller.text,
        style: DropdownMenuTheme.of(context).textStyle,
      ),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();
    return DropdownMenu(
      width: controller.text.isEmpty ? 100 : textPainter.size.width + 90,
      enabled: enabled ?? true,
      controller: controller,
      dropdownMenuEntries: entries,
      onSelected:
          selectAction ??
          (value) {
            setState(() {});
          },
    );
  }
}
