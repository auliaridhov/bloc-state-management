import '../../models/product_model.dart';

class CartState {
  final List<Product> cartItems;

  CartState({this.cartItems = const []});
}
