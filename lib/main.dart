import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/providers/product_provider.dart';
import 'package:rancho/providers/shoppingcart_provider.dart';
import 'package:rancho/screens/auth.dart';
import 'package:rancho/services/firestore_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ShoppingcartProvider()),
        StreamProvider(create: (context) => firestoreService.getProducts()),
        StreamProvider(create: (context) => firestoreService.getShoppingcart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff560027),
          accentColor: Color(0xffbc477b),
          brightness: Brightness.dark,
        ),
        title: 'Rancho no Supermercado',
//        home: ProductView(),
        home: LoginView(),
      ),
    );
  }
}
