import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note_app_test_task/data/model/note_model.dart';
import 'package:note_app_test_task/data/repository/note_repository.dart';
class NoteCubit extends Cubit<List<NoteModel>> {
  NoteCubit() : super([]);

  final NoteRepository _noteRepository = NoteRepository();

  void addNote(
    String title,
    String description,
    BuildContext context,
  ) async {
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and description cannot be empty'),
        ),
      );
      return;
    }
    await _noteRepository.addNoteToFirestore(title, description);

    getNote();
  }

  void getNote() async {
    final notes = await _noteRepository.getNoteFromFirestore();
    emit(notes);
  }

  void deleteNote(String docId) async {
    await _noteRepository.deleteNoteFromFirestore(docId);
    getNote();
  }
}

