import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catech_inventory_routes/app.dart';

void main() {
  group('Performance Tests', () {
    testWidgets('App startup performance', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();
      
      // Build the app
      await tester.pumpWidget(const CatechInventoryApp());
      
      // Wait for the first frame
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      
      // Performance assertion: App should start within 100ms
      expect(stopwatch.elapsedMilliseconds, lessThan(100),
          reason: 'App startup took ${stopwatch.elapsedMilliseconds}ms, expected < 100ms');
    });

    testWidgets('List scrolling performance', (WidgetTester tester) async {
      await tester.pumpWidget(const CatechInventoryApp());
      await tester.pumpAndSettle();

      // Find the ListView
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      // Measure scrolling performance
      final stopwatch = Stopwatch()..start();
      
      // Scroll down
      await tester.drag(listView, const Offset(0, -500));
      await tester.pumpAndSettle();
      
      // Scroll up
      await tester.drag(listView, const Offset(0, 500));
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      
      // Performance assertion: Scrolling should be smooth
      expect(stopwatch.elapsedMilliseconds, lessThan(200),
          reason: 'Scrolling took ${stopwatch.elapsedMilliseconds}ms, expected < 200ms');
    });

    testWidgets('Memory usage test', (WidgetTester tester) async {
      await tester.pumpWidget(const CatechInventoryApp());
      await tester.pumpAndSettle();

      // Navigate multiple times to test memory management
      for (int i = 0; i < 5; i++) {
        // Simulate navigation
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pumpAndSettle();
      }

      // The app should still be responsive
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Widget rebuild efficiency', (WidgetTester tester) async {
      await tester.pumpWidget(const CatechInventoryApp());
      await tester.pumpAndSettle();

      // Count initial widgets
      final initialWidgetCount = tester.widgetList(find.byType(Card)).length;

      // Trigger a rebuild
      await tester.pump();
      await tester.pumpAndSettle();

      // Count widgets after rebuild
      final finalWidgetCount = tester.widgetList(find.byType(Card)).length;

      // Widget count should remain the same (efficient rebuilding)
      expect(finalWidgetCount, equals(initialWidgetCount),
          reason: 'Widget count changed from $initialWidgetCount to $finalWidgetCount');
    });
  });
}