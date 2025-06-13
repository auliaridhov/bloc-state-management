class Product {
  final int id;
  final String name;
  final int price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Product && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
