import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    //cria o arquivo que represnta o banco de dados
    final String path = join(dbPath, 'finances.db');

    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE IF NOT EXISTS type_expense ('
          'id INTEGER PRIMARY KEY,'
          'description TEXT,'
          'color TEXT)');
      db.execute('CREATE TABLE IF NOT EXISTS expenses ('
          'id INTEGER PRIMARY KEY,'
          'value REAL,'
          'type_expense INTEGER,'
          'FOREIGN KEY(type_expense) REFERENCES type_expense(id))');
    }, version: 2);
  });
}

Future<int> saveExpenseType(ExpenseType type) {
  return createDatabase().then((db) {
    final Map<String, dynamic> typeMap = Map();
    typeMap['description'] = type.description;
    typeMap['color'] = type.color;
    return db.insert('type_expense', typeMap);
  });
}

Future<int> saveExpense(Expense expense) {
  return createDatabase().then((db) {
    final Map<String, dynamic> expenseMap = Map();
    expenseMap['value'] = expense.value;
    expenseMap['type_expense'] = expense.category.index;
    return db.insert('expenses', expenseMap);
  });
}

Future<List<Expense>> findAllExpense() {
  return createDatabase().then((db) {
    return db.query('expenses').then((maps) {
      final List<Expense> expenses = List();
      for (Map<String, dynamic> map in maps) {
        final Expense expense = Expense(
          id: map['id'],
          value: map['value'],
          category: map['type_expense'],
        );
        expenses.add(expense);
      }
      return expenses;
    });
  });
}

Future<List<ExpenseType>> findAllExpenseType() {
  return createDatabase().then((db) {
    return db.query('type_expense').then((maps) {
      final List<ExpenseType> types = List();
      for (Map<String, dynamic> map in maps) {
        final ExpenseType type = ExpenseType(
          index: map['id'],
          description: map['description'],
          color: map['color'],
        );
        types.add(type);
      }
      return types;
    });
  });
}
