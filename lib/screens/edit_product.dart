import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:rancho/models/product.dart';
import 'package:rancho/providers/product_provider.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct([this.product]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final upcController = TextEditingController();
  final descriptionController = TextEditingController();
  final unitController = TextEditingController();
  final typeController = TextEditingController();
  final priceController = TextEditingController();

//  final isincartController = TextEditingController();

  @override
  void dispose() {
    upcController.dispose();
    descriptionController.dispose();
    unitController.dispose();
    typeController.dispose();
    priceController.dispose();
//    isincartController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product == null) {
      // New record
      upcController.text = '';
      descriptionController.text = '';
      unitController.text = '';
      typeController.text = '';
      priceController.text = '';
//      isincartController.text = '';
      new Future.delayed(Duration.zero, () {
        final produtctProvider =
            Provider.of<ProductProvider>(context, listen: false);
        produtctProvider.loadValues(Product());
      });
    } else {
      // Existing record
      // Controller update
      upcController.text = widget.product.upc;
      descriptionController.text = widget.product.description;
      unitController.text = widget.product.unit;
      typeController.text = widget.product.type;
      priceController.text = widget.product.price.toString();
//      isincartController.text = widget.product.isincart.toString();
      // State update
      new Future.delayed(Duration.zero, () {
        final produtctProvider =
            Provider.of<ProductProvider>(context, listen: false);
        produtctProvider.loadValues(widget.product);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final produtctProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Incluir/Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: upcController,
              decoration: InputDecoration(hintText: 'Código'),
              onChanged: (value) {
                produtctProvider.changeUpc(value);
              },
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Descrição'),
              onChanged: (value) {
                produtctProvider.changeDescription(value);
              },
            ),
            TextField(
              controller: unitController,
              decoration: InputDecoration(hintText: 'Unidade'),
              onChanged: (value) {
                produtctProvider.changeUnit(value);
              },
            ),
            TextField(
              controller: typeController,
              decoration: InputDecoration(hintText: 'Categoria'),
              onChanged: (value) {
                produtctProvider.changeType(value);
              },
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'Valor'),
              onChanged: (value) {
                produtctProvider.changePrice(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                child: Text('Salvar'),
                onPressed: () {
                  produtctProvider.changeIsInCart(false);
                  produtctProvider.saveProduct();
                  Navigator.of(context).pop();
                }),
            (widget.product != null)
                ? RaisedButton(
                color: Colors.red,
                child: Text('Apagar'),
                onPressed: () {
                  produtctProvider.removeProduct(widget.product.productId);
                  Navigator.of(context).pop();
                }): MaterialButton(
              height: 54.0,
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              child: Text(
                'Ler Código de Barras',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                FlutterBarcodeScanner.scanBarcode(
                    '#000000', 'Cancelar', true, ScanMode.BARCODE)
                    .then((value) => setState(() {
                  produtctProvider.changeUpc(value);
                  upcController.text = value;
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
