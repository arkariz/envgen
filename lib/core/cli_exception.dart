/// Exception thrown by CLI operations.
///
/// This exception is used throughout the envflare_cli codebase
/// to indicate errors that should be displayed to the user.
class CliException implements Exception {
  /// The error message to display.
  final String message;

  /// Creates a new CLI exception with the given message.
  CliException(this.message);

  @override
  String toString() => message;
}