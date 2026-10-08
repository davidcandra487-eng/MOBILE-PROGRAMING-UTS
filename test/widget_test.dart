import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:project_uts/providers/app_state.dart';
import 'package:project_uts/screens/main_navigation.dart';

void main() {
  group('Uniqlo App Integration Tests', () {
    testWidgets('Main Navigation loads correctly with Provider', (WidgetTester tester) async {
      // Menjalankan widget yang telah terbungkus Provider
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AppState(),
          child: const MaterialApp(
            home: MainNavigation(),
          ),
        ),
      );

      // Memastikan navigasi bottom bar terpasang dengan benar
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Katalog'), findsOneWidget);
      expect(find.text('Wishlist'), findsOneWidget);
      expect(find.text('Keranjang'), findsOneWidget);
    });
  });
}