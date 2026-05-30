import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppConfig {
  late Client client;
  final String endPoint = "https://sgp.cloud.appwrite.io/v1";
  final String projectID = "6a156f90000efb4f18a2";

  late Databases database;
  final String databaseID = "6a17e5c20007d11f6c81";

  AppConfig() {
    client = Client().setEndpoint(endPoint).setProject(projectID);
    database = Databases(client);
  }

  Future<String> checkConnection() async {
    return await AppConfig().client.ping();
  }

  Future<RowList> fetchPertandinganAktif() async {
    TablesDB tablesDB = TablesDB(client);
    try {
      RowList result = await tablesDB.listRows(
        databaseId: databaseID,
        tableId: "pertandingan",
        queries: [Query.equal('status', 'aktif')],
        total: false,
        ttl: 0
      ).timeout(Duration(seconds: 10));
      return result;
    } on AppwriteException catch (e) {
      throw AppwriteException(e.toString());
    }
  }
}
