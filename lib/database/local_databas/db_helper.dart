import 'dart:io';

import 'package:expense_tracker_sqflite/models/budget_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  /// Budget Table
  static const String TABLE_BUDGET = "BUDGET_TABLE";
  static const String TABLE_BUDGET_COLUMN_ID = "id";
  static const String TABLE_BUDGET_COLUMN_AMOUNT = "amount";
  static const String TABLE_BUDGET_COLUMN_CREATEDAT = "createdAt";
  static const String TABLE_BUDGET_COLUMN_UPDATEDAT = "updatedAt";

  /// Expense Table
  static const String TABLE_EXPENSE = "EXPENSE_TABLE";
  static const String TABLE_EXPENSE_COLUMN_ID = "ID";
  static const String TABLE_EXPENSE_COLUMN_TITLE = "TITLE";
  static const String TABLE_EXPENSE_COLUMN_AMOUNT = "AMOUNT";
  static const String TABLE_EXPENSE_COLUMN_CATEGORY = "CATEGORY";
  static const String TABLE_EXPENSE_COLUMN_DATE = "DATE";
  static const String TABLE_EXPENSE_COLUMN_CREATEDAT = "CREATED_AT";
  static const String TABLE_EXPENSE_COLUMN_UPDATEDAT = "UPDATED_AT";

  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  Database? _myDB;

  Future<Database> get getDB async {
    if (_myDB != null) {
      return _myDB!;
    } else {
      _myDB = await _openDB();

      return _myDB!;
    }
  }

  Future<Database> _openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "expenseTracker.db");

    _myDB = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_BUDGET($TABLE_BUDGET_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $TABLE_BUDGET_COLUMN_AMOUNT REAL NOT NULL,
        $TABLE_BUDGET_COLUMN_CREATEDAT TEXT NOT NULL,
        $TABLE_BUDGET_COLUMN_UPDATEDAT TEXT NOT NULL)''');

        await db.execute(''' 
        CREATE TABLE $TABLE_EXPENSE($TABLE_EXPENSE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $TABLE_EXPENSE_COLUMN_TITLE TEXT NOT NULL,
        $TABLE_EXPENSE_COLUMN_AMOUNT REAL NOT NULL,
        $TABLE_EXPENSE_COLUMN_CATEGORY TEXT NOT NULL,
        $TABLE_EXPENSE_COLUMN_DATE TEXT NOT NULL,
        $TABLE_EXPENSE_COLUMN_CREATEDAT TEXT NOT NULL,
        $TABLE_EXPENSE_COLUMN_UPDATEDAT TEXT NOT NULL

        
        
        ) ''');
      },
      version: 1,
    );
    return _myDB!;
  }

  // Budget Setting data

  Future<bool> insertBalance({
    required double amount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    var db = await getDB;
    int rowsEffected = await db.insert(
      TABLE_BUDGET,
      BudgetModel(
        amount: amount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      ).toMap(),
    );
    print("RowsEffected:$rowsEffected");

    return rowsEffected > 0;
  }

  Future<BudgetModel?> getBudget() async {
    var db = await getDB;
    final result = await db.query(TABLE_BUDGET);

    if (result.isNotEmpty) {
      return BudgetModel.fromMap(result.first);
    }
    return null;
  }

  Future<bool> updateBalance({
    required double amount,
    required DateTime updatedAt,
    required int id,
  }) async {
    var db = await getDB;

    int rowsEffected = await db.update(
      TABLE_BUDGET,
      {
        "$TABLE_BUDGET_COLUMN_AMOUNT": amount.toDouble(),
        "$TABLE_BUDGET_COLUMN_UPDATEDAT": updatedAt.toIso8601String(),
      },
      where: "$TABLE_BUDGET_COLUMN_ID=?",
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }
}
