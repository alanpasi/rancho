import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product_shoppingcart.dart';
import 'package:rancho/providers/product_provider.dart';

class Shoppingcart extends StatelessWidget {
  final f = NumberFormat('##0.00', 'pt_BR');

  void removeInCart(context, String productId) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {

    final shoppingcart = Provider.of<List<ProductShoppingcart>>(context);

    var _totalPrice = 0.0;

    for (int i = 0; i < shoppingcart.length; i++) {
      _totalPrice =
          _totalPrice + (shoppingcart[i].price * shoppingcart[i].quantity);
      print('$i ===> ${shoppingcart[i].quantity}');
    }
    print('Total: ${f.format(_totalPrice)}');

    return Scaffold(
        appBar: AppBar(
          title: Text('Produtos no Carrinho'),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 30.0,
          child: Text('Total: R\$ ${f.format(_totalPrice)}'),
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
                        trailing: Text(
                            'R\$ ${f.format(shoppingcart[index].price)}\nQuantidade: ${f.format(shoppingcart[index].quantity)}\nSub-total: R\$ ${f.format(shoppingcart[index].price * shoppingcart[index].quantity)}'),
                        onTap: () {},
                        onLongPress: () {
                          removeInCart(context, shoppingcart[index].productId);
                        },
                      ),
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
