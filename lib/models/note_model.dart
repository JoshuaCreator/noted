class NoteModel {
  String title, content;
  String? id;
  DateTime? createdAt;
  final bool? archived;
  NoteModel({
    this.archived = false,
    this.id,
    required this.title,
    required this.content,
    this.createdAt,
  });
}
