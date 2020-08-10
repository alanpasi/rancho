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
  final quantityController = TextEditingController();
  final isincartController = TextEditingController();

  @override
  void dispose() {
    upcController.dispose();
    descriptionController.dispose();
    unitController.dispose();
    typeController.dispose();
    priceController.dispose();
    quantityController.dispose();
    isincartController.dispose();
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
      quantityController.text = '';
      isincartController.text = '';
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(Product());
      });
    } else {
      // Existing record
      // Controller update
      upcController.text = widget.product.upc;
      descriptionController.text = widget.product.description;
      unitController.text = widget.product.unit;
      typeController.text = widget.product.type;
      priceController.text = widget.product.price.toString();
      quantityController.text = widget.product.quantity.toString();
      isincartController.text = widget.product.isincart.toString();
      // State update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Incluir/Editar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: upcController,
              decoration: InputDecoration(hintText: 'Código'),
              onChanged: (value) {
                productProvider.changeUpc(value);
              },
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Descrição'),
              onChanged: (value) {
                productProvider.changeDescription(value);
              },
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: unitController,
              decoration: InputDecoration(hintText: 'Unidade'),
              onChanged: (value) {
                productProvider.changeUnit(value);
              },
            ),
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: typeController,
              decoration: InputDecoration(hintText: 'Categoria'),
              onChanged: (value) {
                productProvider.changeType(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: InputDecoration(hintText: 'Valor'),
              onChanged: (value) {
                productProvider.changePrice(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: quantityController,
              decoration: InputDecoration(hintText: 'Quantidade'),
              onChanged: (value) {
                productProvider.changeQuantity(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
                child: Text('Salvar'),
                onPressed: () {
                  productProvider.changeIsInCart(true);
                  productProvider.saveProduct();
                  Navigator.of(context).pop();
                }),
            (widget.product != null)
                ? RaisedButton(
                color: Colors.red,
                child: Text('Apagar'),
                onPressed: () {
                  productProvider.removeProduct(widget.product.productId);
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
                  productProvider.changeUpc(value);
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
