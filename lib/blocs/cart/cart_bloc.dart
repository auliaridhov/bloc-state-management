import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>((event, emit) {
      final items = List<Product>.from(state.cartItems);
      final index = items.indexWhere((p) => p.id == event.product.id);

      if (index >= 0) {
        // Update quantity if exists
        final existing = items[index];
        items[index] = existing.copyWith(quantity: existing.quantity + 1);
      } else {
        // Add new product
        items.add(event.product);
      }

      emit(CartState(cartItems: items));
    });

    on<RemoveFromCart>((event, emit) {
      final items = List<Product>.from(state.cartItems);
      final index = items.indexWhere((p) => p.id == event.product.id);

      if (index >= 0) {
        final existing = items[index];
        if (existing.quantity > 1) {
          items[index] = existing.copyWith(quantity: existing.quantity - 1);
        } else {
          items.removeAt(index);
        }
      }

      emit(CartState(cartItems: items));
    });

    on<ClearCart>((event, emit) {
      emit(CartState(cartItems: []));
    });

    on<DeleteFromCart>((event, emit) {
      final items = List<Product>.from(state.cartItems)
        ..removeWhere((p) => p.id == event.product.id);
      emit(CartState(cartItems: items));
    });
  }
}
