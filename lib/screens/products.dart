import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product.dart';
import 'package:rancho/screens/edit_product.dart';
import 'package:rancho/screens/shoppingcart.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Produtos'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProduct()));
                })
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                child: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Shoppingcart()));
                }),
          ],
        ),
        body: (products != null)
            ? ListView.builder(
                itemCount: products.length,
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
                        isThreeLine: true,
                        title: Text('(${index + 1})\n${products[index].upc}'),
                        subtitle: Text(
                            '${products[index].description}\n${products[index].unit} - ${products[index].type}'),
                        trailing: Text('R\$ ${products[index].price.toString()}'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditProduct(products[index])));
                        },
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
