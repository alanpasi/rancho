import 'package:flutter/material.dart';

class Shoppingcart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Produtos'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {}),
        ],
      ),
      body: Text('ListView de produtos no ShoppingCart'),
    );
  }
}
