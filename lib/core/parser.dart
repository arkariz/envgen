import 'dart:io';

/// Parses an environment file into a key-value map.
///
/// Reads a .env file and converts each line in KEY=VALUE format
/// into a map entry. Lines without '=' are ignored.
///
/// Returns an empty map if the file doesn't exist.
Map<String, String> parseEnv(File file) {
  if (!file.existsSync()) return {};

  final map = <String, String>{};

  for (final line in file.readAsLinesSync()) {
    if (!line.contains('=')) continue;

    final idx = line.indexOf('=');
    map[line.substring(0, idx)] = line.substring(idx + 1);
  }

  return map;
}