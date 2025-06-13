import '../../models/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class ClearCart extends CartEvent {}

class DeleteFromCart extends CartEvent {
  final Product product;
  DeleteFromCart(this.product);
}
