import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/repository/app_database.dart';
import 'package:finances/repository/category_dao.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDao {
  static const createTable = 'CREATE TABLE IF NOT EXISTS $tableName ('
      '$_id INTEGER PRIMARY KEY,'
      '$_value REAL,'
      '$_category INTEGER,'
      'FOREIGN KEY($_category) REFERENCES $_categoryTable(id))';

  static const tableName = 'expenses';
  static const _id = 'id';
  static const _value = 'value';
  static const _category = 'category';
  static const _categoryTable = CategoryDao.tableName;

  Future<int> saveExpense(Expense expense) async {
    Database db = await createDatabase();
    final Map<String, dynamic> expenseMap = Map();
    expenseMap[_value] = expense.value;
    expenseMap[_category] = expense.category.index;
    return db.insert(tableName, expenseMap);
  }

  Future<List<Expense>> findAllExpense() async {
    CategoryDao categoryDao = CategoryDao();

    Database db = await createDatabase();
    List<Category> categories = await categoryDao.findAllCategories();
    List<Map<String, dynamic>> results = await db.query(tableName);

    final List<Expense> expenses = List();
    for (Map<String, dynamic> map in results) {
      Category type =
          categories.firstWhere((type) => type.index == map[_category]);
      final Expense expense = Expense(
        id: map[_id],
        value: map[_value],
        category: type,
      );
      expenses.add(expense);
    }
    return expenses;
  }
}
