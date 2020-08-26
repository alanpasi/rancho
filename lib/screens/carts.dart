import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/cart.dart';
import 'package:rancho/providers/cart_provider.dart';
import 'package:rancho/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:rancho/screens/items.dart';

class Carts extends StatelessWidget {
  final firestoreService = FirestoreService();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final carts = Provider.of<List<Cart>>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Carrinhos'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          cartProvider.saveCart();
        },
      ),
      body: (carts != null)
          ? ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: ListTile(
                      title: Text(carts[index].date),
                      trailing: Text('${index + 1}/${carts.length}'),
                      onTap: () {
                        print('cart[index] ===>>> $index');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Items()));
                      },
                    ),
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
