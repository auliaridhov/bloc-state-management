import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/product_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  final products = List.generate(
    5,
        (index) => Product(id: index, name: 'Product $index', price: (index + 1) * 1000),
  );

  ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"), actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartPage())),
        ),
      ]),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Rp ${product.price}'),
            trailing: ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddToCart(product));
                // Create a snackbar to show the product was added
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
              child: Text('Add'),
            ),
          );
        },
      ),
    );
  }
}
