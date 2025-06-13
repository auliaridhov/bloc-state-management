// import 'package:bloctutorial/blocs/cart/cart_bloc.dart';
// import 'package:bloctutorial/blocs/cart/cart_event.dart';
// import 'package:bloctutorial/blocs/cart/cart_state.dart';
// import 'package:bloctutorial/models/product_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';

// void main() {
//   final product1 = Product(id: 1, name: 'Kopi', price: 20000);
//   final product2 = Product(id: 2, name: 'Teh', price: 15000);

//   group('CartBloc', () {
//     blocTest<CartBloc, CartState>(
//       'Menambahkan produk ke keranjang',
//       build: () => CartBloc(),
//       act: (bloc) => bloc.add(AddToCart(product1)),
//       expect: () => [
//         CartState(cartItems: [
//           product1,
//         ])
//       ],
//     );

//     blocTest<CartBloc, CartState>(
//       'Menambahkan produk yang sama 2x menambah kuantitas',
//       build: () => CartBloc(),
//       act: (bloc) {
//         bloc.add(AddToCart(product1));
//         bloc.add(AddToCart(product1));
//       },
//       expect: () => [
//         CartState(cartItems: [product1]),
//         CartState(cartItems: [product1.copyWith(quantity: 2)]),
//       ],
//     );

//     blocTest<CartBloc, CartState>(
//       'Mengurangi kuantitas produk',
//       build: () => CartBloc(),
//       seed: () => CartState(cartItems: [
//         product1.copyWith(quantity: 2),
//       ]),
//       act: (bloc) => bloc.add(RemoveFromCart(product1)),
//       expect: () => [
//         CartState(cartItems: [product1.copyWith(quantity: 1)]),
//       ],
//     );

//     blocTest<CartBloc, CartState>(
//       'Menghapus produk dari keranjang',
//       build: () => CartBloc(),
//       seed: () => CartState(cartItems: [
//         product1.copyWith(quantity: 2),
//         product2,
//       ]),
//       act: (bloc) => bloc.add(RemoveFromCart(product1)),
//       expect: () => [
//         CartState(cartItems: [
//           product2,
//         ]),
//       ],
//     );
//   });
// }
