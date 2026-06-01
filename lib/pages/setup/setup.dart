import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import '../../classes/arena.dart';
import '../../pages/game/game.dart';
import '../../backend/app_config.dart';
import 'package:dart_ping/dart_ping.dart';

// Map<String, Map<String, dynamic>> events = {
//   'location 1': {
//     'ring': <String, List<String>>{
//       'Arena 1': ['Game 1', 'Game 2', 'Game 3'],
//       'Arena 2': ['Game 1', 'Game 2', 'Game 3'],
//       'Arena 3': ['Game 1', 'Game 2', 'Game 3'],
//     },
//     'judge': <String>['Judge 1', 'Judge 2', 'Judge 3'],
//   },
// };

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupState();
}

class _SetupState extends State<SetupScreen>
    with SingleTickerProviderStateMixin {
  final _matchController = TextEditingController();
  final _fightController = TextEditingController();
  final _judgeController = TextEditingController();
  final _passkeyController = TextEditingController();

  late List<DropdownMenuEntry> pertandinganList;
  // void loadPertandingan() async {
  //   try {
  //     RowList response = await AppConfig().fetchPertandinganAktif();
  //     setState(() {
  //       // pertandinganList = response.convertTo<DropdownMenuEntry<String>>((p0) => DropdownMenuEntry(value: p0., label: label))
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // loadPertandingan();
  }

  @override
  void dispose() {
    _matchController.dispose();
    _fightController.dispose();
    _judgeController.dispose();
    _passkeyController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  bool isConnected = false;
  bool isInvalidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
        // actions: [
        //   Text(isConnected ? "Tersambung" : "Belum Tersambung"),
        //   Icon(
        //     Icons.square,
        //     color: isConnected ? Colors.green : Colors.red.shade900,
        //   ),
        // ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          // loadPertandingan();
        },
        style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
        child: Icon(Icons.refresh),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: Colors.black),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: MediaQuery.widthOf(context) * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24,
              children: [
                LayoutBuilder(
                  builder: (ctx, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("Pertandingan"),
                      dataDropdownMenu(
                        constraint: constraints,
                        controller: _matchController,
                        label: Text("Pilih Pertandingan"),
                        entries: [],
                      ),
                      Text("Petarungan"),
                      dataDropdownMenu(
                        constraint: constraints,
                        controller: _fightController,
                        enabled: _matchController.text.isNotEmpty,
                        label: Text("Pilih Petarungan"),
                        entries: [],
                      ),
                      Text("Juri"),
                      dataDropdownMenu(
                        constraint: constraints,
                        controller: _judgeController,
                        enabled: _matchController.text.isNotEmpty,
                        label: Text("Pilih Juri"),
                        entries: [],
                      ),
                      Text("Passkey"),
                      TextField(
                        enabled: _judgeController.text.isNotEmpty,
                        controller: _passkeyController,
                        decoration: InputDecoration(
                          labelText: "Masukkan Passkey",
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    textStyle: TextStyle(fontSize: 32),
                  ),
                  onPressed: () {
                    // if (_fightController.text.isEmpty ||
                    //     _judgeController.text.isEmpty ||
                    //     _matchController.text.isEmpty ||
                    //     _passkeyController.text.isEmpty) {}
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Text("Masuk"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataDropdownMenu({
    required BoxConstraints constraint,
    required TextEditingController controller,
    required List<DropdownMenuEntry<String>> entries,
    Widget? label,
    ValueChanged<String?>? selectAction,
    bool? enabled,
  }) {
    return DropdownMenu(
      enabled: enabled ?? true,
      width: constraint.maxWidth,
      label: label,
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
