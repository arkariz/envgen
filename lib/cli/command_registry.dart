import 'package:envflare_cli/commands/index.dart';

class CommandRegistry {
  final Map<String, BaseCommand> _commands = {};

  void register(BaseCommand command) {
    _commands[command.name] = command;
  }

  BaseCommand? get(String name) => _commands[name];

  Iterable<BaseCommand> get all => _commands.values;
}