import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/repository/category_dao.dart';
import 'package:finances/repository/expense_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'finances.db');
    
    return openDatabase(path, onCreate: (db, version) {
      db.execute(CategoryDao.createTable);
      db.execute(ExpenseDao.createTable);
    }, version: 1);
  });
}
