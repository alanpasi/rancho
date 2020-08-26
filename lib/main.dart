import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rancho/providers/cart_provider.dart';
import 'package:rancho/providers/product_provider.dart';
import 'package:rancho/screens/auth.dart';
import 'package:rancho/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyAppInit());
}

class MyAppInit extends StatefulWidget {
  final Widget child;

  const MyAppInit({Key key, @required this.child}) : super(key: key);

  @override
  _MyAppInitState createState() => _MyAppInitState();
}

class _MyAppInitState extends State<MyAppInit> {
  Future<FirebaseApp> _initialization;
  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }
          return CircularProgressIndicator();
    });
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        StreamProvider(create: (context) => firestoreService.getProducts()),
        StreamProvider(create: (context) => firestoreService.getCarts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff560027),
          accentColor: Color(0xffbc477b),
          brightness: Brightness.dark,
        ),
        title: 'Rancho no Supermercado',
        home: LoginView(),
      ),
    );
  }
}


