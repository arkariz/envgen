import 'dart:io';
import 'dart:convert';

import 'package:envflare_cli/core/index.dart';

/// Configuration management for envflare_cli.
///
/// Handles loading, saving, and managing the .envflare_cli.json configuration file
/// which contains flavor definitions and other project settings.
class Config {
  /// The path to the configuration file.
  static const path = '.envflare_cli.json';

  /// Loads the configuration from the .envflare_cli.json file.
  ///
  /// Throws [CliException] if the configuration file is missing.
  static Map<String, dynamic> load() {
    final file = File(path);

    if (!file.existsSync()) {
      throw CliException('Missing .envflare_cli.json');
    }

    return jsonDecode(file.readAsStringSync());
  }

  /// Loads the list of configured flavors from the configuration.
  ///
  /// Returns an empty list if no flavors are configured.
  static List<String> flavors() {
    final config = load();
  /// Saves the configuration to the .envflare_cli.json file.
  ///
  /// The configuration is saved with proper JSON formatting.
    return List<String>.from(config['flavors'] ?? []);
  }

  static void save(Map<String, dynamic> json) {
    File(path).writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(json),
  /// Initializes the configuration file with default values.
  ///
  /// Creates the .envflare_cli.json file if it doesn't exist,
  /// with an empty flavors array.
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