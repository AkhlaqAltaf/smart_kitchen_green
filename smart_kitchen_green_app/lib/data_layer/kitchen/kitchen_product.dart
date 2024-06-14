class Product {
  final int? id;
  final String name;
  final String quantity;
  final String expiryDate;

  Product({this.id, required this.name, required this.quantity, required this.expiryDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'expiryDate': expiryDate,
    };
  }
}
