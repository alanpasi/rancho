class ProductShoppingcart {
  final String productId;
  final String upc;
  final String description;
  final String unit;
  final double price;
  final String type;
  final bool isincart;

  ProductShoppingcart(
      {this.productId,
        this.upc,
        this.description,
        this.unit,
        this.price,
        this.type,
        this.isincart});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'upc': upc,
      'description': description,
      'unit': unit,
      'price': price,
      'type': type,
      'isincart': isincart
    };
  }

  ProductShoppingcart.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        upc = firestore['upc'],
        description = firestore['description'],
        unit = firestore['unit'],
        price = firestore['price'],
        type = firestore['type'],
        isincart = firestore['isincart'];
}
