import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/core/index.dart';

class WizardAddFlavorCommand implements BaseCommand {
  @override
  String get name => 'wizard:add-flavor';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    Config.load();
    final schema = Schema.load();

    Logger.plain('🍦 Add a new flavor');
    Logger.plain('');

    final name = Interactive.ask('Flavor name');
    Config.addFlavor(name);

    // Create new flavor with schema keys
    final env = <String, String>{};
    for (final field in schema) {
      env[field.key] = '';
    }

    // Ask for values for each schema key
    if (schema.isNotEmpty) {
      Logger.plain('');
      Logger.plain('Set values for environment keys:');
      for (final field in schema) {
        final value = Interactive.ask('  ${field.key}', required: false);
        if (value.isNotEmpty) {
          env[field.key] = value;
        }
      }
    }

    writeEnv(EnvFile.file(name), env);

    Logger.success('Flavor "$name" added');
  }
}
