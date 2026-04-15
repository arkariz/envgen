import 'dart:io';

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