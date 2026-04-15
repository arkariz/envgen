import 'package:args/args.dart';
import 'package:envgen/cli/index.dart';
import 'package:envgen/core/index.dart';

class CliRunner {
  final CommandRegistry registry;

  CliRunner(this.registry);

  Future<void> run(List<String> args) async {
    final parser = ArgParser();
    parser.addFlag('help', abbr: 'h', help: 'Show help');

    for (final cmd in registry.all) {
      cmd.configure(parser.addCommand(cmd.name));
    }

    try {
      final result = parser.parse(args);
      final cmdName = result.command?.name;

      if (result['help'] || cmdName == null) {
        if (cmdName != null) {
          // Show help for specific command
          final command = registry.get(cmdName);
          if (command != null) {
            final subParser = ArgParser();
            command.configure(subParser);
            Logger.plain('Usage: envgen $cmdName [options]');
            Logger.plain('');
            Logger.plain(subParser.usage);
          }
        } else {
          // Show global help
          Logger.plain('envgen - A CLI tool for managing Flutter environment variables');
          Logger.plain('');
          Logger.plain('Usage: envgen <command> [options]');
          Logger.plain('');
          Logger.plain('Commands:');
          for (final cmd in registry.all) {
            Logger.plain('  ${cmd.name}');
          }
          Logger.plain('');
          Logger.plain('Use "envgen <command> --help" for more information about a command.');
        }
        return;
      }

      final command = registry.get(cmdName);

      if (command == null) {
        throw CliException('Unknown command: $cmdName');
      }

      await command.execute(result.command!);
    } on CliException catch (e) {
      Logger.error(e.message);
    } catch (e) {
      Logger.error('Unexpected error: $e');
    }
  }
}