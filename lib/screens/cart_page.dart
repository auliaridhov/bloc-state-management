import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return Center(child: Text("Your cart is empty"));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (_, index) {
                    final item = state.cartItems[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text('Qty: ${item.quantity} x Rp ${item.price} = Rp ${item.quantity * item.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // context.read<CartBloc>().add(RemoveFromCart(item));
                                // Create confirmation dialog if the quantity is 1 to confirm quantity deleted
                                if (item.quantity > 1) {
                                  context.read<CartBloc>().add(RemoveFromCart(item));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Confirm Delete'),
                                      content: Text('Are you sure you want to remove ${item.name} from the cart?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(DeleteFromCart(item));
                                            Navigator.pop(context);
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                context.read<CartBloc>().add(AddToCart(item));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // context.read<CartBloc>().add(DeleteFromCart(item));
                                // Create confirmation dialog to confirm deletion
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text('Are you sure you want to remove ${item.name} from the cart?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(DeleteFromCart(item));
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),


              ),
              // Add a total price display and checkout button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rp ${state.cartItems.fold(0, (total, item) => total + (item.price * item.quantity))}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CheckoutPage()),
                        );
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
