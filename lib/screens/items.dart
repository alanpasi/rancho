import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rancho/screens/products.dart';

class Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Itens no Carrinho'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          print('Abre a tela de produtos...');
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Products()));
        },
      ),
      body: Column(
        children: <Widget>[
          Text('cartId ==================>', textAlign: TextAlign.center,),

        ],
      ),
    );
  }
}
