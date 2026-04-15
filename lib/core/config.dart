import 'dart:io';
import 'dart:convert';

import 'package:envflare_cli/core/index.dart';

class Config {
  static const path = '.envflare_cli.json';

  static Map<String, dynamic> load() {
    final file = File(path);

    if (!file.existsSync()) {
      throw CliException('Missing .envflare_cli.json');
    }

    return jsonDecode(file.readAsStringSync());
  }

  static List<String> flavors() {
    final config = load();
    return List<String>.from(config['flavors'] ?? []);
  }

  static void save(Map<String, dynamic> json) {
    File(path).writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(json),
    );
  }

  static void init() {
    final file = File(path);

    if (!file.existsSync()) {
      file.writeAsStringSync(jsonEncode({
        "flavors": []
      }));
    }
  }
}