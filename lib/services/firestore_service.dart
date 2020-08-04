import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rancho/models/product.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .document(product.productId)
        .setData(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Product.fromFirestore(document.data)).toList());
  }

  Future<void> removeProduct(String producId) {
    return _db.collection('products').document(producId).delete();
  }
}
