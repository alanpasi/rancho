import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/providers/product_provider.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    final produtctProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Código'),
              onChanged: (value) {
                produtctProvider.changeUpc(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Descrição'),
              onChanged: (value) {
                produtctProvider.changeDescription(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Unidade'),
              onChanged: (value) {
                produtctProvider.changeUnit(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Categoria'),
              onChanged: (value) {
                produtctProvider.changeType(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Valor'),
              onChanged: (value) {
                produtctProvider.changePrice(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(child: Text('Salvar'), onPressed: () {
              produtctProvider.saveProduct();
            }),
            RaisedButton(
                color: Colors.red, child: Text('Apagar'), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
