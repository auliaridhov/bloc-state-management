import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../blocs/cart/cart_bloc.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItems = context.read<CartBloc>().state.cartItems;
    final total = cartItems.fold<int>(0, (sum, item) => sum + (item.price * item.quantity),);

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...cartItems.map((item) => ListTile(
              title: Text(item.name),
              subtitle: Text('Qty: ${item.quantity} x Rp ${item.price}'),
              trailing: Text('Rp ${item.price}'),
            )),
            Divider(),
            ListTile(
              title: Text("Total"),
              trailing: Text('Rp $total'),
            ),
          ],
        ),
      ),
    );
  }
}
