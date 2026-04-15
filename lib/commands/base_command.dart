import 'package:args/args.dart';

/// Base class for all CLI commands in envflare_cli.
///
/// Commands should extend this class and implement the required methods
/// to integrate with the CLI runner.
abstract class BaseCommand {
  /// The name of this command as used in the CLI.
  String get name;

  /// Configures the argument parser for this command.
  ///
  /// Add command-specific options and flags to the provided parser.
  void configure(ArgParser parser);

  /// Executes the command with the parsed arguments.
  ///
  /// Implement the main logic of the command here.
  Future<void> execute(ArgResults args);
}