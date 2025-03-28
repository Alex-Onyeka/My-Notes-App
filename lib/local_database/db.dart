import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Database? _db;

  Future<void> open() async {
    if (_db != null) {
      final docsDir =
          await getApplicationDocumentsDirectory();

      final mainPath = join(docsDir.path, dbName);

      final db = await openDatabase(mainPath);
      _db = db;

      // Create database
      const createThemeDatabae =
          ''' CREATE TABLE IF NOT EXISTS "theme" (
	          "is_dark"	INTEGER NOT NULL DEFAULT 0
            ); ''';
      db.execute(createThemeDatabae);
    } else {
      return;
    }
  }
}

const dbName = 'local.db';
