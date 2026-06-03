import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart' hide Row;
import 'package:flutter/src/widgets/basic.dart';
import 'package:pertarungan/backend/app_config.dart';
import 'package:pertarungan/pages/setup/components/processes/get_data.dart';
import 'package:pertarungan/pages/setup/components/ui/alert_dialog.dart';
import '../../pages/game/game.dart';

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

  late Map<String, List<DropdownMenuEntry<String>>?> entries = {
    'pertandingan': [],
    'pertarungan': [],
    'juri': [],
  };

  Map<String, Map<String, String>> selectedValues = {
    'pertandingan': {'id': '', 'value': ''},
    'pertarungan': {'id': '', 'value': ''},
    'juri': {'id': '', 'value': ''},
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

  void getPertandingan() async {
    setState(() => isLoadingPertandingan = true);
    entries['pertandingan'] = await fetchData(
      context: context,
      tableID: 'pertandingan',
      columnID: 'nama_pertandingan',
      queries: [
        Query.equal('status', ['aktif']),
      ],
    );
    setState(() => isLoadingPertandingan = false);
  }

  void getPertarungan(String value) async {
    setState(() => isLoadingPetarungan = true);
    entries['pertarungan'] = await fetchData(
      context: context,
      tableID: 'petarungan',
      columnID: 'nama_petarungan',
      queries: [
        Query.and([
          Query.equal('nama_pertandingan', [value]),
          Query.isNull('pemenang_petarungan'),
        ]),
      ],
    );
    setState(() => isLoadingPetarungan = false);
  }

  void getJuri(String value) async {
    setState(() => isLoadingJuri = true);
    await TablesDB(AppConfig().client)
        .listRows(
          databaseId: AppConfig().databaseID,
          tableId: 'juri_petarungan',
          total: false,
          queries: [
            Query.select(['juri.nama_juri']),
            Query.equal('petarungan', [value]),
          ],
        )
        .timeout(
          Duration(seconds: 5),
          onTimeout: () {
            if (mounted) {
              displayDialog(
                context,
                'Error Jaringan',
                'Koneksi jaringan terlalu lambat atau tidak stabil. Silakan coba lagi.',
              );
            }
            setState(() => isLoadingJuri = false);
            throw AppwriteException('Connection timed out');
          },
        )
        .then(
          (value) => {
            entries['juri'] = value.rows
                .map(
                  (e) => DropdownMenuEntry(
                    value: e.$id,
                    label: e.data['juri']['nama_juri'],
                  ),
                )
                .toList(),
          },
        );
    setState(() => isLoadingJuri = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: Colors.black),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: MediaQuery.widthOf(context) * 0.8,
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
                                  reloadAction: () {
                                    _matchController.text = '';
                                    _judgeController.text = '';
                                    _fightController.text = '';
                                    getPertandingan();
                                  },
                                  selectAction: (value) {
                                    if (value != null) {
                                      selectedValues['pertandingan'] = {
                                        'id': value,
                                        'value': entries['pertandingan']!
                                            .firstWhere(
                                              (element) =>
                                                  element.value == value,
                                            )
                                            .label,
                                      };
                                      getPertarungan(value.toString());
                                    }
                                  },
                                ),
                          // pertarungan
                          Text("Petarungan"),
                          isLoadingPetarungan
                              ? CircularProgressIndicator()
                              : dataDropdownMenu(
                                  constraint: constraints,
                                  controller: _fightController,
                                  enabled: _matchController.text.isNotEmpty,
                                  label: Text("Pilih Petarungan"),
                                  entries: entries['pertarungan'] ?? [],
                                  reloadAction: () {
                                    _fightController.text = '';
                                    _judgeController.text = '';
                                    getPertarungan(
                                      selectedValues['pertandingan']!['id']!,
                                    );
                                    setState(() {});
                                  },
                                  selectAction: (value) {
                                    if (value != null) {
                                      selectedValues['pertarungan'] = {
                                        'id': value,
                                        'value': entries['pertarungan']!
                                            .firstWhere(
                                              (element) =>
                                                  element.value == value,
                                            )
                                            .label,
                                      };
                                      getJuri(value);
                                    }
                                  },
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
                                  reloadAction: () {
                                    _judgeController.text = '';
                                    getJuri(
                                      selectedValues['pertarungan']!['id']!,
                                    );
                                  },
                                  selectAction: (value) {
                                    if (value != null) {
                                      selectedValues['juri'] = {
                                        'id': value,
                                        'value': entries['juri']!
                                            .firstWhere(
                                              (element) =>
                                                  element.value == value,
                                            )
                                            .label,
                                      };
                                    }
                                  },
                                ),
                          Text("Passkey"),
                          TextField(
                            enabled: _judgeController.text.isNotEmpty,
                            controller: _passkeyController,
                            decoration: const InputDecoration(
                              labelText: "Masukkan Passkey",
                              fillColor: Colors.white,
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
                        if (_fightController.text.isEmpty ||
                            _judgeController.text.isEmpty ||
                            _matchController.text.isEmpty ||
                            _passkeyController.text.isEmpty) {
                              // TODO: Implement focus to empty fields
                              return;
                            }
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
    void Function()? reloadAction,
    bool? enabled,
  }) {
    return Row(
      spacing: 10,
      children: [
        DropdownMenu<String>(
          selectOnly: true,
          enabled: enabled ?? true,
          width: constraint.maxWidth * 0.91 - 10,
          label: label,
          controller: controller,
          dropdownMenuEntries: entries,
          onSelected:
              selectAction ??
              (value) {
                setState(() {});
              },
        ),
        IconButton(
          onPressed: (enabled == null || enabled) ? reloadAction : null,
          icon: Icon(Icons.refresh),
        ),
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: (enabled == null || enabled)
                ? () {
                    controller.text = '';
                    setState(() {});
                  }
                : null,
            icon: Icon(Icons.cancel_outlined),
          ),
      ],
    );
  }
}
