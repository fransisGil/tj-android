import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pertarungan/backend/app_config.dart';
import 'package:pertarungan/pages/setup/components/ui/alert_dialog.dart';

Future<dynamic> fetchData({
  required BuildContext context,
  required String tableID,
  String? columnID,
  List<String>? queries,
}) async {
  try {
    List<DropdownMenuEntry<String>> dropdownList = [];
    await AppConfig().tablesDB
        .listRows(
          databaseId: AppConfig().databaseID,
          tableId: tableID,
          queries: queries ?? [],
        )
        .timeout(
          Duration(seconds: 5),
          onTimeout: () {
            if (context.mounted) {
              displayDialog(
                context,
                'Error Jaringan',
                'Koneksi jaringan terlalu lambat atau tidak stabil. Silakan coba lagi.',
              );
            }
            throw AppwriteException('Connection timed out');
          },
        )
        .then(
          (value) => {
            dropdownList = value.rows
                .map(
                  (e) => DropdownMenuEntry(
                    value: e.$id,
                    label: columnID != null
                        ? e.data[columnID]
                        : e.data.toString(), // for debugging purposes only
                  ),
                )
                .toList(),
          },
        );
    return dropdownList;
  } on AppwriteException catch (e) {
    if (context.mounted) {
      displayDialog(
        context,
        'Error Jaringan',
        'Ada masalah dengan hubungan jaringan.\nKode masalah: ${e.code}: ${e.toString()}',
      );
    }
    return [];
  }
}

