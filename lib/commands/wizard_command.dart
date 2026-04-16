import 'package:envflare_cli/commands/index.dart';
import 'package:envflare_cli/commands/wizard/wizard_init_command.dart';
import 'package:envflare_cli/commands/wizard/wizard_add_flavor_command.dart';
import 'package:envflare_cli/commands/wizard/wizard_add_env_key_command.dart';
import 'package:envflare_cli/commands/wizard/wizard_remove_env_key_command.dart';
import 'package:envflare_cli/core/index.dart';

class WizardCommand implements BaseCommand {
  @override
  String get name => 'wizard';

  @override
  void configure(parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help');
  }

  @override
  Future<void> execute(args) async {
    Logger.plain('🧙‍♂️ Welcome to the Envflare Wizard!');
    Logger.plain('');
    Logger.plain('Choose what you want to do:');
    Logger.plain('');

    final options = [
      'Initialize project with flavors and keys',
      'Add a new flavor',
      'Add a new environment variable key',
      'Remove an environment variable key',
    ];

    final choice = Interactive.choose('Select an option', options);

    Logger.plain('');

    switch (choice) {
      case 'Initialize project with flavors and keys':
        await WizardInitCommand().execute(args);
        break;
      case 'Add a new flavor':
        await WizardAddFlavorCommand().execute(args);
        break;
      case 'Add a new environment variable key':
        await WizardAddEnvKeyCommand().execute(args);
        break;
      case 'Remove an environment variable key':
        await WizardRemoveEnvKeyCommand().execute(args);
        break;
    }

    final generate = Interactive.confirm('Do you want to generate the .env files?');
    if (generate) {
      await EnvGenerateCommand().execute(args);
    }
  }
}