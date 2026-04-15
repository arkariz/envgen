import 'dart:io';

import 'package:envgen/core/index.dart';

class SchemaField {
  final String key;

  SchemaField(this.key);
}

class Schema {
  static const path = '.env.schema';

  static List<SchemaField> load() {
    final file = File(path);

    if (!file.existsSync()) {
      throw CliException('Missing schema');
    }

    return file.readAsLinesSync()
        .where((e) => e.trim().isNotEmpty)
        .map((line) {
      return SchemaField(line);
    }).toList();
  }

  static void init() {
    final file = File(path);

    if (!file.existsSync()) {
      file.writeAsStringSync('API_URL');
    }
  }
}