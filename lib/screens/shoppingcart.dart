import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product_shoppingcart.dart';

class Shoppingcart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingcart = Provider.of<List<ProductShoppingcart>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos no Carrinho'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {}),
        ],
      ),
      body: (shoppingcart != null) ? ListView.builder(
          itemCount: shoppingcart.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListTile(
                  isThreeLine: true,
                  title: Text('(${index + 1})\n${shoppingcart[index].upc}'),
                  subtitle: Text(
                      '${shoppingcart[index].description}\n${shoppingcart[index].unit} - ${shoppingcart[index].type}'),
                  trailing: Text('R\$ ${shoppingcart[index].price.toString()}'),
                  onTap: () {
                  },
                ),

              ),
            );
          })
            : Center(child: CircularProgressIndicator())
    );
  }
}
