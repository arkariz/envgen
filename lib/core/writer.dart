import 'dart:io';

void writeEnv(File file, Map<String, String> data) {
  final buffer = StringBuffer();

  data.forEach((k, v) {
    buffer.writeln('$k=$v');
  });

  file.writeAsStringSync(buffer.toString());
}