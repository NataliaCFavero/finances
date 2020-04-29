import 'package:finances/models/expense_types.dart';
import 'package:finances/repository/app_database.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  static const createTable = 'CREATE TABLE IF NOT EXISTS $tableName ('
      '$_id INTEGER PRIMARY KEY,'
      '$_description TEXT,'
      '$_color TEXT)';

  static const tableName = 'category';

  static const _id = 'id';
  static const _description = 'description';
  static const _color = 'color';

  Future<int> saveExpenseType(Category type) async {
    Database db = await createDatabase();
    final Map<String, dynamic> typeMap = Map();
    typeMap[_description] = type.description;
    typeMap[_color] = type.color;
    return db.insert(tableName, typeMap);
  }

  Future<List<Category>> findAllCategories() async {
    Database db = await createDatabase();
    List<Map<String, dynamic>> results = await db.query(tableName);

    final List<Category> types = List();
    for (Map<String, dynamic> map in results) {
      final Category type = Category(
        index: map[_id],
        description: map[_description],
        color: map[_color],
      );
      types.add(type);
    }
    return types;
  }
}
