import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getRootDirectory() async {

  Logger logger;
  try {
    final Directory appDocumentsDirectory =
    await getApplicationDocumentsDirectory();

    Directory rootDir =
    Directory('${appDocumentsDirectory.path}/test');
    final bool isRootExists = rootDir.existsSync();

    if (!isRootExists) {
      rootDir = await rootDir.create();
    }

    return rootDir.path;
  } catch (error) {
    logger.warning('Could not get root directory', error);
    rethrow;
  }
}