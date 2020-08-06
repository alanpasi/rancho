import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product_shoppingcart.dart';
import 'package:rancho/providers/product_provider.dart';

class Shoppingcart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('================Shoppingcart/build==================');

    final shoppingcart = Provider.of<List<ProductShoppingcart>>(context);

    var _totalPrice = 0.0;

//    print(shoppingcart.length);
//    print(shoppingcart[0].price);
//    print(shoppingcart[1].price);
    for (int i = 0; i < shoppingcart.length; i++) {
      _totalPrice = _totalPrice + (shoppingcart[i].price.toDouble() * shoppingcart[i].quantity);
      print(shoppingcart[i].quantity);
    }
    print('Total: $_totalPrice');

    return Scaffold(
        appBar: AppBar(
          title: Text('Produtos no Carrinho'),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 30.0,
          child: Text('Total: R\$ $_totalPrice'),
        ),
        body: (shoppingcart != null)
            ? ListView.builder(
                itemCount: shoppingcart.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                            '${index + 1}/${shoppingcart.length}\n${shoppingcart[index].upc}'),
                        subtitle: Text(
                            '${shoppingcart[index].description}\n${shoppingcart[index].unit} - ${shoppingcart[index].type}'),
                        trailing:
                            Text('R\$ ${shoppingcart[index].price.toString()}\nQuantidade: ${shoppingcart[index].quantity.toString()}'),
                        onLongPress: () {
                          RemoveInCart(context, shoppingcart[index].productId);
                        },
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}

void RemoveInCart(context, String productId) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  print('$productId');
  productProvider.updateIsInCart(productId, false);
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      'Produto excluído no Carrinho',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Color(0xff560027),
  ));
}
