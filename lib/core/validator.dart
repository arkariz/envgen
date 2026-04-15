import 'package:envgen/core/index.dart';

class Validator {
  static void validateAll() {
    final schema = Schema.load();

    for (final flavor in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(flavor));

      for (final field in schema) {
        final value = env[field.key];

        if (value == null) {
          throw CliException('Missing ${field.key} in $flavor');
        }
      }

      Logger.success('✅ $flavor valid');
    }
  }
}