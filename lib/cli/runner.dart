import 'package:args/args.dart';
import 'package:envgen/cli/index.dart';
import 'package:envgen/core/index.dart';

class CliRunner {
  final CommandRegistry registry;

  CliRunner(this.registry);

  Future<void> run(List<String> args) async {
    final parser = ArgParser();

    for (final cmd in registry.all) {
      cmd.configure(parser.addCommand(cmd.name));
    }

    try {
      final result = parser.parse(args);
      final cmdName = result.command?.name;

      if (cmdName == null) {
        Logger.info('Usage: envgen <command>');
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