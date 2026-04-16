import 'dart:io';

import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class WizardRemoveEnvKeyCommand implements BaseCommand {
  @override
  String get name => 'wizard:remove-env-key';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    Logger.plain('🗑️  Remove an environment variable key');
    Logger.plain('');

    final key = Interactive.ask('Environment variable key to remove');

    final schemaFile = File('.env.schema');

    if (!schemaFile.existsSync()) {
      throw CliException('No schema file found');
    }

    final lines = schemaFile.readAsLinesSync();
    if (!lines.any((l) => l.trim() == key)) {
      throw CliException('Key "$key" not found in schema');
    }

    // Confirm deletion
    Logger.plain('');
    final confirm = Interactive.confirm('Remove key "$key" from schema and all flavors?');

    if (!confirm) {
      Logger.warning('⏸️  Operation cancelled');
      return;
    }

    // Remove from schema
    final updatedLines = lines.where((l) => l.trim() != key).toList();
    schemaFile.writeAsStringSync(updatedLines.join('\n'));

    Logger.info('Removed "$key" from schema');

    // Remove from all flavors
    for (final flavor in EnvFile.flavors()) {
      final env = parseEnv(EnvFile.file(flavor));
      env.remove(key);
      writeEnv(EnvFile.file(flavor), env);
    }

    Logger.success('Key "$key" removed from schema and all flavors');
  }
}
