import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card/cart_provider/provider.dart';
import 'package:shopping_card/screens/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (create)=> CartProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductList(),
    ),
    );

  }
}

