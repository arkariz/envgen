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

  /// Adds a new key to the schema.
  ///
  /// Throws [CliException] if the key already exists in the schema.
  static void addKey(String key) {
    if (_isKeyExists(key)) {
      throw CliException('Key "$key" already exists in schema');
    }

    final file = File(path);
    file.writeAsStringSync('$key\n', mode: FileMode.append);
  }

  /// Removes a key from the schema.
  /// 
  /// Throws [CliException] if the key does not exist in the schema.
  static void removeKey(String key) {
    if (!_isKeyExists(key)) {
      throw CliException('Key "$key" not found in schema');
    }

    final file = File(path);
    final lines = file.readAsLinesSync();
    final filteredLines = lines..removeWhere((l) => l.trim() == key);
    file.writeAsStringSync(filteredLines.join('\n'));
  }

  /// Creates the .env.schema file if it doesn't exist.
  static void init() {
    final file = File(path);

    if (!file.existsSync()) {
      file.writeAsStringSync('');
    }
  }

  /// Checks if a key already exists in the schema.
  static bool _isKeyExists(String key) {
    return load().any((field) => field.key == key);
  }
}