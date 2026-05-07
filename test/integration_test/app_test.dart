import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bloctutorial/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('Login and navigation flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Check LoginScreen
      expect(find.text('Login'), findsWidgets);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Enter email and password
      await tester.enterText(find.byType(TextField).at(0), 'tes');
      await tester.enterText(find.byType(TextField).at(1), 'tes');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Should navigate to DashboardScreen
      expect(find.byType(Scaffold), findsWidgets);
      // You can add more checks for dashboard widgets here
    });

    testWidgets('Product list and cart flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Simulate login
      await tester.enterText(find.byType(TextField).at(0), 'tes');
      await tester.enterText(find.byType(TextField).at(1), 'tes');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to ProductListPage if not default
      expect(find.text('Products'), findsOneWidget);
      // Add first product to cart
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add').first);
      await tester.pumpAndSettle();
      // Open cart
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      expect(find.text('Your Cart'), findsOneWidget);
      // Proceed to checkout
      // You can add more steps for checkout and assertions
    });
  });
}
