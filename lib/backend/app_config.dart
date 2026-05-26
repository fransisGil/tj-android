import 'package:appwrite/appwrite.dart';


class AppConfig {
  late Client client;
  final String endPoint = "https://sgp.cloud.appwrite.io/v1";
  final String projectID = "6a156f90000efb4f18a2";

  AppConfig() {
    client = Client()
      .setEndpoint(endPoint)
      .setProject(projectID);
  }
}


