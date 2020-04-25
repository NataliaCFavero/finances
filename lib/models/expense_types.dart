class ExpenseType {
  String description;
  int index;
  String color;

  ExpenseType({this.description, this.index, this.color});

  List<ExpenseType> newList() {
    return [
      ExpenseType(index: 1, description: "iFood", color: "vermelho"),
      ExpenseType(index: 2, description: "Restaurante", color: "amarelo"),
      ExpenseType(index: 3, description: "Netflix", color: "preto"),
      ExpenseType(index: 4, description: "Uber", color: "cinza"),
      ExpenseType(index: 5, description: "Supermercado", color: "laranja"),
      ExpenseType(index: 6, description: "Roupas", color: "azul"),
    ];
  }
}
