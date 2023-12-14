class StockItem {
  int? id; // Allow for null to handle auto-incrementing primary key
  String name;
  int quantity;
  double price;
  String category;
  String warehouse;

  StockItem({
    this.id, // Named parameter 'id'
    required this.name,
    required this.quantity,
    required this.price,
    required this.category,
    required this.warehouse,
  });

  // Factory method to create a StockItem from a map
  factory StockItem.fromMap(Map<String, dynamic> map) {
    return StockItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      category: map['category'],
      warehouse: map['warehouse'],
    );
  }

  // Map the object to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'category': category,
      'warehouse': warehouse,
    };
  }
}
