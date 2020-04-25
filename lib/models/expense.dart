import 'package:finances/models/expense_types.dart';

class Expense {
  final int id;
  final double value;
  final ExpenseType category;

  Expense({this.id, this.value, this.category});

  @override
  String toString() {
    return 'Expense{value: $value, category: $category}';
  }
}
