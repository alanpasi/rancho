import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rancho/models/product.dart';
import 'package:rancho/models/product_shoppingcart.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .document(product.productId)
        .setData(product.toMap());
  }

  Future<void> saveProductShoppincart(ProductShoppingcart productShoppingcart) {
    return _db
        .collection('products')
        .document(productShoppingcart.productId)
        .setData(productShoppingcart.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').orderBy('description').snapshots().map(
        (snapshot) => snapshot.documents
            .map((document) => Product.fromFirestore(document.data))
            .toList());
  }

  Stream<List<ProductShoppingcart>> getShoppingcart() {
    return _db
        .collection('products')
        .orderBy('description')
        .where('isincart', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => ProductShoppingcart.fromFirestore(document.data))
            .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('products').document(productId).delete();
  }

  Future<void> updateIsInCart(String productId, bool isInCart) {
    return _db
        .collection('products')
        .document(productId)
        .updateData({'isincart': isInCart});
  }
}
