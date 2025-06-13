import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloctutorial/screens/login_screen.dart';
import 'package:bloctutorial/screens/dashboard_screen.dart';
import 'package:bloctutorial/screens/product_list_page.dart';
import 'package:bloctutorial/screens/cart_page.dart';
import 'package:bloctutorial/screens/checkout_page.dart';
import 'package:bloctutorial/screens/user_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloctutorial/blocs/login/login_bloc.dart';
import 'package:bloctutorial/blocs/user/user_bloc.dart';
import 'package:bloctutorial/blocs/weather/weather_bloc.dart';
import 'package:bloctutorial/blocs/user_detail/user_detail_bloc.dart';
import 'package:bloctutorial/blocs/cart/cart_bloc.dart';
import 'package:bloctutorial/repositories/user_repository.dart';
import 'package:bloctutorial/repositories/weather_repository.dart';

Widget wrapWithProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LoginBloc()),
      BlocProvider(create: (_) => UserBloc(UserRepository())),
      BlocProvider(create: (_) => WeatherBloc(WeatherRepository())),
      BlocProvider(create: (_) => UserDetailBloc(UserRepository())),
      BlocProvider(create: (_) => CartBloc()),
    ],
    child: MaterialApp(home: child),
  );
}

void main() {
  testWidgets('LoginScreen UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(LoginScreen()));
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    // Check if the email and password fields are present
    expect(find.byType(TextField), findsNWidgets(2)); // Assuming 2 text fields for email and password

    // Check if the login button is present
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('DashboardScreen UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(DashboardScreen()));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.textContaining('Dashboard'), findsNothing); // Adjust if you have a title
    expect(find.byType(ListTile), findsWidgets); // Assuming there are ListTiles for products

  });

  testWidgets('ProductListPage UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(ProductListPage()));
    expect(find.text('Products'), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('CartPage UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(CartPage()));
    expect(find.text('Your Cart'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('CheckoutPage UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(CheckoutPage()));
    expect(find.text('Checkout'), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('UserDetailScreen UI smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWithProviders(UserDetailScreen(userId: 1)));
    expect(find.text('User Detail'), findsOneWidget);
    // Loading indicator or user info
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
