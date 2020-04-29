class Category {
  String description;
  int index;
  String color;

  Category({this.description, this.index, this.color});

  List<Category> newList() {
    return [
      Category(index: 1, description: "iFood", color: "#d50000"),
      Category(index: 2, description: "Restaurante", color: "#ffd600"),
      Category(index: 3, description: "Netflix", color: "#212121"),
      Category(index: 4, description: "Uber", color: "#616161"),
      Category(index: 5, description: "Supermercado", color: "#ff6d00"),
      Category(index: 6, description: "Roupas", color: "#304ffe"),
    ];
  }
}
