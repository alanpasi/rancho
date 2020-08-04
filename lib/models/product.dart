class Product {
  final String productId;
  final String upc;
  final String description;
  final String unit;
  final double price;
  final String type;
  final bool isincart;

  Product(
      {this.productId,
      this.upc,
      this.description,
      this.unit,
      this.price,
      this.type,
      this.isincart});
}
