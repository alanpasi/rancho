import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product.dart';
import 'package:rancho/providers/product_provider.dart';
import 'package:rancho/screens/edit_product.dart';
import 'package:rancho/screens/shoppingcart.dart';

class Products extends StatelessWidget {
  final f = NumberFormat('##0.00', 'pt_BR');

  void addInCart(context, String productId) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    print('$productId');
    productProvider.updateIsInCart(productId, true);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'Produto incluído no Carrinho',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xff560027),
    ));
  }

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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Shoppingcart()));
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
                        title: Text(
                            '${index + 1}/${products.length}\n${products[index].upc}'),
                        subtitle: Text(
                            '${products[index].description}\n${products[index].unit} - ${products[index].type}'),
                        trailing:
                            Text('R\$ ${f.format(products[index].price)}'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditProduct(products[index])));
                        },
                        onLongPress: () {
                          addInCart(context, products[index].productId);
                        },
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
