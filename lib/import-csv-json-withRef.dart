//Importe sua planilha CSV com parametros de referencia a outra coleção no Firebase
//Creditos: https://github.com/bulgariamitko

import 'dart:io';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:csv/csv.dart';
import '../../backend/firebase_storage/storage.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../flutter_flow/upload_data.dart';

Future importFromCsvOrJson(
  BuildContext context,
  String? divider,
  String? collectionName,
  String? fieldName1,
  DocumentReference docuRef,
) async {
  // null safety check
  divider = divider ?? ',';
  collectionName ??= 'users';
  fieldName1 ??= 'error';

  // Get a reference to the Firestore database
  final firestore = FirebaseFirestore.instance;

  // TODO: Change collection name
  final collectionRef = firestore.collection(collectionName);

  final selectedFile = await selectFile(allowedExtensions: ['csv', 'json']);

  if (selectedFile != null) {
    showUploadMessage(
      context,
      'Adicionando arquivo...',
      showLoading: true,
    );

    final fileString = utf8.decode(selectedFile.bytes);

    List<String> rows = [];
    String fileType = 'csv';
    Map<String, dynamic> doc = {};
    // if file is json
    if (selectedFile.storagePath.contains('json')) {
      fileType = 'json';
      List<dynamic> rows = jsonDecode(fileString);

      for (var row in rows) {
    
        DocumentReference docRef = firestore.doc(row['docRef']);

        await collectionRef.add({
          fieldName1: row['Email'],
        });
      }
    } else {
      rows = fileString.split('\n');

      int i = 0;
      for (var row in rows) {
        i++;

        // skip the head fields
        if (i == 1) {
          continue;
        }

        List<String> fields = row.split(divider);


        await collectionRef.add({fieldName1: fields[0], 'docRef': docuRef});
      }
    }

    showUploadMessage(
      context,
      'Successo!',
    );
  }
}

//Import  package CSV - https://pub.dev/packages/csv