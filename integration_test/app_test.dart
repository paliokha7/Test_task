import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:note_app_test_task/main.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  group('Note app integration tests', () {
    testWidgets('Add a note on the home screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      final titleField = find.byType(TextFormField).first;
      final descriptionField = find.byType(TextFormField).last;
      await tester.enterText(titleField, 'Test note title');
      await tester.enterText(descriptionField, 'Test note description');

      await tester.tap(find.byIcon(Icons.save));
    });
  });
}
