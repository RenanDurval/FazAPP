import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:idea_forge/main.dart';
import 'package:provider/provider.dart';
import 'package:idea_forge/builder/drag_drop_engine.dart';
import 'package:idea_forge/marketplace/marketplace_provider.dart';

void main() {
  testWidgets('App starts and shows bottom navigation', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DragDropEngine()),
          ChangeNotifierProvider(create: (_) => MarketplaceProvider()),
        ],
        child: const IdeaForgeApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify navigations exist
    expect(find.text('Criar App'), findsOneWidget);
    expect(find.text('Marketplace'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);

    // Verify initial screen is Builder
    expect(find.text('App Builder Pro'), findsOneWidget);
  });
}
