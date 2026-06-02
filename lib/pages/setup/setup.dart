import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart' hide Row;
import 'package:pertarungan/pages/setup/components/processes/get_data.dart';
import 'package:pertarungan/pages/setup/components/ui/alert_dialog.dart';
// import '../../classes/arena.dart';
import '../../pages/game/game.dart';
import '../../backend/app_config.dart';

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

  late Map<String, List<DropdownMenuEntry<String>>> entries = {
    'pertandingan': [],
    'pertarungan': [],
    'juri': [],
  };

  @override
  void initState() {
    getPertandingan();
    super.initState();
  }

  @override
  void dispose() {
    _matchController.dispose();
    _fightController.dispose();
    _judgeController.dispose();
    _passkeyController.dispose();
    super.dispose();
  }

  bool isLoadingPertandingan = false;
  bool isLoadingPetarungan = false;
  bool isLoadingJuri = false;
  bool isInvalidated = false;

  void getData({
    required String entry,
    required String tableID,
    required String columnID,
    String query = '',
    required bool? loadState,
  }) async {
    setState(() {
      loadState = true;
    });
    entries[entry] = await fetchData(
      context: context,
      tableID: tableID,
      columnID: columnID,
      queries: [query],
    );
    setState(() {
      loadState = false;
    });
  }

  void getPertandingan() => getData(
    entry: 'pertandingan',
    tableID: 'pertandingan',
    columnID: 'nama_pertandingan',
    loadState: isLoadingPertandingan,
    query: Query.equal('nama_pertandingan', ['aktif']),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          if (_matchController.text.isEmpty) {
            getPertandingan();
          }
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
            height: MediaQuery.heightOf(context) * 0.8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          isLoadingPertandingan
                              ? CircularProgressIndicator()
                              : dataDropdownMenu(
                                  constraint: constraints,
                                  controller: _matchController,
                                  label: Text("Pilih Pertandingan"),
                                  entries: entries['pertandingan'] ?? [],
                                ),
                          Text("Petarungan"),
                          isLoadingPetarungan
                              ? CircularProgressIndicator()
                              : dataDropdownMenu(
                                  constraint: constraints,
                                  controller: _fightController,
                                  enabled: _matchController.text.isNotEmpty,
                                  label: Text("Pilih Petarungan"),
                                  entries: entries['pertarungan'] ?? [],
                                ),
                          Text("Juri"),
                          isLoadingJuri
                              ? CircularProgressIndicator()
                              : dataDropdownMenu(
                                  constraint: constraints,
                                  controller: _judgeController,
                                  enabled:
                                      _matchController.text.isNotEmpty &&
                                      _fightController.text.isNotEmpty,
                                  label: Text("Pilih Juri"),
                                  entries: entries['juri'] ?? [],
                                ),
                          Text("Passkey"),
                          TextField(
                            enabled: _judgeController.text.isNotEmpty,
                            controller: _passkeyController,
                            decoration: const InputDecoration(
                              labelText: "Masukkan Passkey",
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
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
