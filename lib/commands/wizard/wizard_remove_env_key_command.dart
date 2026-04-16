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
    Schema.load();
    Logger.plain('🗑️  Remove an environment variable key');
    Logger.plain('');

    final schemaKey = Schema.load().map((item) => item.key).toList();
    final key = Interactive.choose('Environment variable key to remove', schemaKey);

    // Confirm deletion
    Logger.plain('');
    final confirm = Interactive.confirm('Remove key "$key" from schema and all flavors?');

    if (!confirm) {
      Logger.warning('⏸️  Operation cancelled');
      return;
    }

    // Remove from schema
    Schema.removeKey(key);
    Logger.info('Removed "$key" from schema');

    // Remove from all flavors
    EnvFile.removeVariable(key);

    Logger.success('Key "$key" removed from schema and all flavors');
  }
}
