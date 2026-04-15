import 'package:envflare_cli/commands/index.dart';

/// Registry for CLI commands.
///
/// Manages the collection of available commands and provides
/// methods to register and retrieve commands by name.
class CommandRegistry {
  final Map<String, BaseCommand> _commands = {};

  /// Registers a command in the registry.
  void register(BaseCommand command) {
    _commands[command.name] = command;
  }

  /// Retrieves a command by its name.
  ///
  /// Returns null if no command with the given name is registered.
  BaseCommand? get(String name) => _commands[name];

  /// Gets all registered commands.
  Iterable<BaseCommand> get all => _commands.values;
}