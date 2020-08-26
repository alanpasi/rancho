import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rancho/models/cart.dart';
import 'package:rancho/models/product.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Future<void> saveCart(Cart cart) {
    return _db.collection('carts').doc(cart.cartId).set(cart.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').orderBy('description').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Product.fromFirestore(doc.data()))
            .toList());
  }

  Stream<List<Cart>> getCarts() {
    return _db.collection('carts').orderBy('date').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => Cart.fromFirestore(doc.data()))
            .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }

  Future<void> updateIsInCart(String productId, bool isInCart) {
    return _db
        .collection('products')
        .doc(productId)
        .update({'isincart': isInCart});
  }
}
