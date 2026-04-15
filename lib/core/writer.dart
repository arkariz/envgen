import 'dart:io';

/// Writes a key-value map to an environment file.
///
/// Converts a [Map<String, String>] to KEY=VALUE format
/// and writes it to the specified file.
void writeEnv(File file, Map<String, String> data) {
  final buffer = StringBuffer();

  data.forEach((k, v) {
    buffer.writeln('$k=$v');
  });

  file.writeAsStringSync(buffer.toString());
}