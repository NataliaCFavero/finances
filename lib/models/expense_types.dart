class ExpenseType {
  String description;
  int index;

  ExpenseType({this.description, this.index});

  List<ExpenseType> newList() {
    return [
      ExpenseType(index: 1, description: "iFood"),
      ExpenseType(index: 2, description: "Restaurante"),
      ExpenseType(index: 3, description: "Netflix"),
      ExpenseType(index: 4, description: "Uber"),
      ExpenseType(index: 5, description: "Supermercado"),
      ExpenseType(index: 6, description: "Roupas"),
    ];
  }
}
