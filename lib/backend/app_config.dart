import 'package:appwrite/appwrite.dart';

class AppConfig {
  late Client client;
  final String endPoint = "https://sgp.cloud.appwrite.io/v1";
  final String projectID = "6a156f90000efb4f18a2";

  late Account account;

  late Databases database;
  final String databaseID = "6a17e5c20007d11f6c81";

  AppConfig() {
    client = Client().setEndpoint(endPoint).setProject(projectID);
    database = Databases(client);
    account = Account(client);
  }

  // Future<void> login(BuildContext context) async {
  // };
}
