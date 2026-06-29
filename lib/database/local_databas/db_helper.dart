import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();

      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "expenseTracker.db");

    myDB = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute("");
      },
      version: 1,
    );
    return myDB!;
  }
}
