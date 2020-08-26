import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rancho/models/cart.dart';
import 'package:rancho/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _date;
  String _cartId;
  var uuid = Uuid();

  // Getters
  String get date => _date;

  // Setters
  changeDate(String value) {
    _date = value;
    notifyListeners();
  }

  saveCart() {
    var _thisInstant = new DateTime.now();
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm:ss').format(_thisInstant);
    var newCart = Cart(date: formattedDate, cartId: uuid.v4());
    firestoreService.saveCart(newCart);
  }
}
