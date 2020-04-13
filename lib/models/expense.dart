class Expense {
  final double value;
  final String category;

  Expense(this.value, this.category);

  @override
  String toString() {
    return 'Expense{value: $value, category: $category}';
  }
}
