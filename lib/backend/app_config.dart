import 'package:appwrite/appwrite.dart';
import 'package:pertarungan/classes/arena.dart';

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

void sendRincian(Arena arena, String setPemenang) async {
  try {
    final row = await AppConfig().tablesDB.upsertRow(
      databaseId: AppConfig().databaseID, tableId: 'rincian_poin', rowId: ID.unique(), data: {
        'rondePetarungan': arena.rounds[0].id,
        'sudutPetarungan': ''
      });
  } on AppwriteException catch(e) {
    print(e);
  }
}

// void sendDetails({required Fighter fighter}) {
//   try {

//   }
// }