import 'package:flutter/material.dart';
import 'package:rancho/models/product_shoppingcart.dart';
import 'package:rancho/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ShoppingcartProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _upc;
  String _description;
  String _unit;
  double _price;
  String _type;
  bool _isincart;
  String _productId;
  var uuid = Uuid();

  // Getters
  String get upc => _upc;

  String get description => _description;

  String get unit => _unit;

  double get price => _price;

  String get type => _type;

  bool get isincart => _isincart;

  changeIsInCart(bool value) {
    _isincart = value;
    notifyListeners();
  }

  loadValues(ProductShoppingcart productShoppingcart) {
    _upc = productShoppingcart.upc;
    _description = productShoppingcart.description;
    _unit = productShoppingcart.unit;
    _type = productShoppingcart.type;
    _price = productShoppingcart.price;
    _productId = productShoppingcart.productId;
  }

  saveProductShoppingcart() {
    print('$_productId, $upc, $description, $unit, $price, $type, $isincart');
      // Update product
      var updateProduct = ProductShoppingcart(
          upc: upc,
          description: description,
          unit: unit,
          price: price,
          type: type,
          isincart: isincart,
          productId: _productId);
      firestoreService.saveProductShoppincart(updateProduct);

  }
}
