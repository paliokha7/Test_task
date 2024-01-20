import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_app_test_task/data/repository/note_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late NoteRepository repository;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repository = NoteRepository(firestore: fakeFirestore);
  });

  test('addNoteToFirestore should add a note to Firestore', () async {
    const title = 'Test Title';
    const description = 'Test Description';

    await repository.addNoteToFirestore(title, description);

    final addedNote = await fakeFirestore.collection('notes').get();
    expect(addedNote.docs.length, 1);
    final data = addedNote.docs.first.data();
    expect(data['title'], title);
    expect(data['description'], description);
  });

  test('getNoteFromFirestore should get notes from Firestore', () async {
    await fakeFirestore.collection('notes').add({
      'title': 'Note 1',
      'description': 'Description 1',
    });
    await fakeFirestore.collection('notes').add({
      'title': 'Note 2',
      'description': 'Description 2',
    });

    final notes = await repository.getNoteFromFirestore();
    expect(notes.length, 2);
    expect(notes[0].title, 'Note 1');
    expect(notes[1].title, 'Note 2');
  });

  test('deleteNoteFromFirestore should delete a note from Firestore', () async {
    final docId = await fakeFirestore.collection('notes').add({
      'title': 'Note to Delete',
      'description': 'Description',
    });

    await repository.deleteNoteFromFirestore(docId.id);

    final notes = await fakeFirestore.collection('notes').get();
    expect(notes.docs.length, 0);
  });
}
