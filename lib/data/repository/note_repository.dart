import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app_test_task/data/model/note_model.dart';

class NoteRepository {
  final CollectionReference notesCollection;

  NoteRepository({FirebaseFirestore? firestore})
      : notesCollection =
            (firestore ?? FirebaseFirestore.instance).collection('notes');

  Future<void> addNoteToFirestore(String title, String description) async {
    try {
      await notesCollection.add({
        'title': title,
        'description': description,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<NoteModel>> getNoteFromFirestore() async {
    try {
      final querySnapshot = await notesCollection.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return NoteModel(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          docId: doc.id,
        );
      }).toList();
    } catch (e) {
      print('Error getting notes: $e');
      return [];
    }
  }

  Future<void> deleteNoteFromFirestore(String docId) async {
    try {
      await notesCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
