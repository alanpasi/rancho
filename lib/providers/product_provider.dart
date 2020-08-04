import 'package:flutter/material.dart';
import 'package:rancho/services/firestore_service.dart';
import 'package:rancho/models/product.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
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

  // Setters
  changeUpc(String value) {
    _upc = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeUnit(String value) {
    _unit = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  changeType(String value) {
    _type = value;
    notifyListeners();
  }

  changeIsInCart(bool value) {
    _isincart = value;
    notifyListeners();
  }

  loadValues(Product product) {
    _upc = product.upc;
    _description = product.description;
    _unit = product.unit;
    _type = product.type;
    _price = product.price;
    _productId = product.productId;
  }

  saveProduct() {
    print('$_productId, $upc, $description, $unit, $price, $type, $isincart');
    if (_productId == null) {
      // New product
      var newProduct = Product(
          upc: upc,
          description: description,
          unit: unit,
          price: price,
          type: type,
          isincart: isincart,
          productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      // Update product
      var updateProduct = Product(
          upc: upc,
          description: description,
          unit: unit,
          price: price,
          type: type,
          isincart: isincart,
          productId: _productId);
      firestoreService.saveProduct(updateProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
