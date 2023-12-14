import 'package:notes_app_riverpod/data/entities/entities.dart';

class Nota {
  final int id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final NoteCategory category;
  Nota( 
      {
      required this.category,
      required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isCompleted});
}
