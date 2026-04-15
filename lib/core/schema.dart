import 'dart:io';

import 'package:envflare_cli/core/index.dart';

/// Represents a single field in the environment schema.
class SchemaField {
  /// The key name of this schema field.
  final String key;

  /// Creates a new schema field with the given key.
  SchemaField(this.key);
}

/// Schema management for environment variables.
///
/// Handles loading and managing the .env.schema file which defines
/// the required environment variables for the project.
class Schema {
  /// The path to the schema file.
  static const path = '.env.schema';

  /// Loads the schema from the .env.schema file.
  ///
  /// Throws [CliException] if the schema file is missing.
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

  /// Initializes the schema file with a default API_URL field.
  ///
  /// Creates the .env.schema file if it doesn't exist.
  static void init() {
    final file = File(path);

    if (!file.existsSync()) {
      file.writeAsStringSync('API_URL');
    }
  }
}