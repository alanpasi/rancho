import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  String _upc;
  String _description;
  String _unit;
  double _price;
  String _type;
  bool _isincart;

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

  saveProduct() {
    print('$upc, $description, $unit, $price, $isincart');
  }
}
