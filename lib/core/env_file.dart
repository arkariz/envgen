import 'dart:io';

import 'package:envgen/core/index.dart';
import 'package:path/path.dart';

class EnvFile {
  static Directory dir() {
    final d = Directory('.envs');
    if (!d.existsSync()) d.createSync();
    return d;
  }

  static File file(String flavor) {
    dir();
    return File(join('.envs', '$flavor.env'));
  }

  static List<String> flavors() => Config.flavors();
}