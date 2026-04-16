import 'dart:io';

import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class WizardInitCommand implements BaseCommand {
  @override
  String get name => 'wizard:init';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    if (File(Config.path).existsSync()) {
      throw CliException('Project already initialized');
    }

    Logger.plain('🚀 Welcome to envflare_cli setup wizard!');
    Logger.plain('');

    Config.init();
    Schema.init();
    Logger.success('Project initialized');
    Logger.plain('');

    // Ask for flavors
    Logger.plain('🍦 Enter your flavors (environments)');
    Logger.plain('   Separate multiple flavors with comma (e.g: dev, staging, production)');
    final flavorInput = Interactive.ask('Flavors', defaultValue: 'development,staging,production');
    if (flavorInput.trim().isEmpty) throw CliException('At least one flavor is required');
    final flavorList = flavorInput
        .split(',')
        .map((f) => f.trim())
        .where((f) => f.isNotEmpty)
        .toList();

    // Create flavors config
    Logger.info('Creating flavors: ${flavorList.join(', ')}');
    Config.save(flavorList);

    // Ask for keys
    Logger.plain('');
    Logger.plain('🔧 Enter environment variable keys');
    Logger.plain('   Separate multiple keys with comma (press Enter to skip)');
    final keyInput = Interactive.ask('Keys', required: true);
    if (keyInput.trim().isEmpty) throw CliException('At least one key is required');
    final keyList = keyInput.isEmpty
        ? <String>[]
        : keyInput
            .split(',')
            .map((k) => k.trim())
            .where((k) => k.isNotEmpty)
            .toList();

    // Create schema
    Schema.addKey(keyList.join('\n'));
    Logger.info('Created schema with keys: ${keyList.join(', ')}');

    // Create flavor env files
    for (final key in keyList) {
      EnvFile.createVariablesForFlavors(key: key);
    }

    Logger.plain('');
    Logger.success('Setup complete with flavors: ${flavorList.join(', ')}');
    Logger.success('Schema keys: ${keyList.join(', ')}');
  }
}
