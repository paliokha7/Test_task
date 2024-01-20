class NoteModel {
  final String title;
  final String description;
  String? docId;

  NoteModel({
    required this.title,
    required this.description,
    this.docId,
  });
}
