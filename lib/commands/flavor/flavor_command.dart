
import 'package:args/args.dart';
import 'package:envgen/commands/index.dart';
import 'package:envgen/core/index.dart';

class FlavorCommand implements BaseCommand {
  @override
  String get name => 'flavor';

  @override
  void configure(ArgParser parser) {
    final addParser = parser.addCommand('add');
    FlavorAddCommand().configure(addParser);

    final removeParser = parser.addCommand('remove');
    FlavorRemoveCommand().configure(removeParser);

    final listParser = parser.addCommand('list');
    FlavorListCommand().configure(listParser);
  }

  @override
  Future<void> execute(ArgResults args) async {
    final sub = args.command;

    if (sub == null) {
      throw CliException('Usage: envgen flavor <add|remove|list>');
    }

    switch (sub.name) {
      case 'add':
        await FlavorAddCommand().execute(sub);
        break;

      case 'remove':
        await FlavorRemoveCommand().execute(sub);
        break;

      case 'list':
        await FlavorListCommand().execute(sub);
        break;

      default:
        throw CliException('Unknown flavor command: ${sub.name}');
    }
  }
}