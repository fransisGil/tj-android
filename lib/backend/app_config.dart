import 'dart:developer' as console;

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:pertarungan/classes/arena.dart';

import '../classes/fighter.dart';

class AppConfig {
  late Client client;
  final String endPoint = "https://sgp.cloud.appwrite.io/v1";
  final String projectID = "6a156f90000efb4f18a2";

  late Account account;

  late Databases database;
  final String databaseID = "6a17e5c20007d11f6c81";

  late TablesDB tablesDB;

  AppConfig() {
    client = Client().setEndpoint(endPoint).setProject(projectID);
    database = Databases(client);
    account = Account(client);
    tablesDB = TablesDB(client);
  }
}

Future<dynamic> getCurrentSession() async {
  try {
    return await AppConfig().account.get();
  } catch (e) {
    console.log(e.toString());
    return Exception('Error');
  }
}

void sendRincian({required Arena arena, String? setPemenang}) async {
  try {
  User user = await getCurrentSession();
  String idRincian = ID.unique();
  TablesDB tablesDB = AppConfig().tablesDB;

  // ronde
  Fighter redFighter = arena.redFighter!.value as Fighter;
  Fighter blackFighter = arena.blackFighter!.value as Fighter;
  await tablesDB.updateRow(
    databaseId: AppConfig().databaseID,
    tableId: 'ronde_petarungan',
    rowId: arena.rounds.first.id,
    data: {
      'pemenang_ronde':
          setPemenang ??
          (redFighter.sumPoints() > blackFighter.sumPoints()
              ? 'merah'
              : redFighter.sumPoints() == blackFighter.sumPoints()
              ? 'seri'
              : 'hitam'),
    },
  );
  console.log('Petarungan berhasil');

  for (Data fighterData in [arena.blackFighter!, arena.redFighter!]) {
    Fighter fighter = fighterData.value as Fighter;
    console.log('Current fighter: ${fighterData.id}');
    console.log('Sending to rincian poin...');
    // rincian poin
    await tablesDB
        .createRow(
          permissions: [
            Permission.read(Role.user(user.$id)),
            Permission.update(Role.user(user.$id)),
          ],
          databaseId: AppConfig().databaseID,
          tableId: 'rincian_poin',
          rowId: idRincian,
          data: {
            'rondePetarungan': arena.rounds.first.id,
            'sudutPetarungan': fighterData.id,
            'juriPetarungan': arena.judge.id,
            'jumlah_poin': fighter.sumPoints(),
          },
        )
        .whenComplete(() => console.log('Create row in rincian complete'));
    console.log('Rincian successful');

    // detail pelanggaran
    await tablesDB.createRow(
      permissions: [
        Permission.read(Role.user(user.$id)),
        Permission.update(Role.user(user.$id)),
      ],
      databaseId: AppConfig().databaseID,
      tableId: 'detail_pelanggaran',
      rowId: ID.unique(),
      data: {
        'rincianPoin': idRincian,
        'ringan': fighter.penalties.ringan,
        'berat': fighter.penalties.berat,
        'tp_pelanggaran': fighter.penalties.sum(),
      },
    );
    console.log('Detail pelanggaran successful');

    // detail_poin_pukulan
    await tablesDB.createRow(
      permissions: [
        Permission.read(Role.user(user.$id)),
        Permission.update(Role.user(user.$id)),
      ],
      databaseId: AppConfig().databaseID,
      tableId: 'detail_poin_pukulan',
      rowId: ID.unique(),
      data: {
        'rincianPoin': idRincian,
        'tp_pukulan': fighter.punch.sum(),
        'muka': fighter.punch.muka,
        'badan': fighter.punch.badan,
        'goyah': fighter.punch.goyah,
      },
    );
    console.log('Detail Poin Pukulan successful');

    // detail_poin_tendangan
    await tablesDB.upsertRow(
      databaseId: AppConfig().databaseID,
      tableId: 'detail_poin_tendangan',
      rowId: ID.unique(),
      data: {
        'rincianPoin': idRincian,
        'tp_pukulan': fighter.kick.sum(),
        'muka': fighter.kick.muka,
        'badan': fighter.kick.badan,
        'goyah': fighter.kick.goyah,
      },
    );
    console.log('Detail Poin Tendangan successful');
  }
  } catch (e, stacktrace) {
    console.log(e.toString() + '\n${stacktrace.toString()}');
  }
}
