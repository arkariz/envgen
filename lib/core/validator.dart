import 'package:envflare_cli/core/index.dart';

class Validator {
  static void validateAll() {
    final schema = Schema.load();
    final invalidFlavors = <String, List<String>>{};

    for (final flavor in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(flavor));
      final invalidKeys = <String>[];

      for (final field in schema) {
        final value = env[field.key];

        if (value == null || value.trim().isEmpty) {
          invalidKeys.add(field.key);
        }
      }

      if (invalidKeys.isNotEmpty) {
        invalidFlavors[flavor] = invalidKeys;
        continue;
      }

      Logger.success('✅ $flavor valid');
    }

    if (invalidFlavors.isNotEmpty) {
      final detail = invalidFlavors.entries
          .map((entry) => '❌ Missing or empty keys in ${entry.key}:\n${entry.value.map((key) => '- $key').join('\n')}')
          .join('\n\n');

      throw CliException("ENV files validation failed:\n\n$detail");
    }
  }
}