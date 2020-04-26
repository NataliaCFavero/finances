class ExpenseType {
  String description;
  int index;
  String color;

  ExpenseType({this.description, this.index, this.color});

  List<ExpenseType> newList() {
    return [
      ExpenseType(index: 1, description: "iFood", color: "#d50000"),
      ExpenseType(index: 2, description: "Restaurante", color: "#ffd600"),
      ExpenseType(index: 3, description: "Netflix", color: "#212121"),
      ExpenseType(index: 4, description: "Uber", color: "#616161"),
      ExpenseType(index: 5, description: "Supermercado", color: "#ff6d00"),
      ExpenseType(index: 6, description: "Roupas", color: "#304ffe"),
    ];
  }
}
