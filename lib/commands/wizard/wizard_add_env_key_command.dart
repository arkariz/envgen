import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class WizardAddEnvKeyCommand implements BaseCommand {
  @override
  String get name => 'wizard:add-env-key';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    Schema.load();
    Config.load();

    Logger.plain('🔧 Add a new environment variable key');
    Logger.plain('');

    // Add to schema
    final key = Interactive.ask('Environment variable key name');
    Schema.addKey(key);
    Logger.info('Added "$key" to schema');

    // Ask for values for each flavor
    Logger.plain('');
    Logger.plain('Set values for each flavor:');
    final flavors = EnvFile.flavors();

    for (final flavor in flavors) {
      final value = Interactive.ask('  $flavor', required: false);
      EnvFile.addVariable(flavor: flavor, key: key, value: value);
    }

    Logger.success('Key "$key" added to schema and all flavors');
  }
}
