import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_app_test_task/cubit/note_cubit.dart';
import 'package:note_app_test_task/data/model/note_model.dart';
import 'package:note_app_test_task/screens/add_notes_page.dart';
import 'package:note_app_test_task/screens/home_page.dart';

class MockNoteCubit extends MockCubit<List<NoteModel>> implements NoteCubit {}

void main() {
  group('HomePage', () {
    testWidgets('Render correctly', (WidgetTester tester) async {
      final notes = [
        NoteModel(
            title: 'Title one', description: 'Description one', docId: '1'),
        NoteModel(
            title: 'Title two', description: 'Description two', docId: '2'),
      ];

      final noteCubit = MockNoteCubit();
      when(() => noteCubit.state).thenReturn(notes);

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<NoteCubit>(
              create: (_) => noteCubit,
            ),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );
      // notes
      expect(find.text('Title one'), findsOneWidget);
      expect(find.text('Title two'), findsOneWidget);
      // button and appbarText
      expect(find.text('Notes'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
  group('AddNotePAge', () {
    testWidgets('Renders correctly', (WidgetTester tester) async {
      final noteCubit = MockNoteCubit();

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<NoteCubit>(
              create: (_) => noteCubit,
            ),
          ],
          child: const MaterialApp(
            home: AddNotePage(),
          ),
        ),
      );

      // App bar title
      expect(find.text('Add Note'), findsOneWidget);

      // Title TextFormField
      expect(find.widgetWithText(TextFormField, 'Title'), findsOneWidget);

      // Description TextFormField
      expect(find.widgetWithText(TextFormField, 'Description'), findsOneWidget);

      // FloatingActionButton
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}
