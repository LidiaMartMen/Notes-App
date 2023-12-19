

import 'package:notes_app_riverpod/data/entities/entities.dart';

class Note2 {
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final NoteCategory? category;
  Note2( 
      {
      required this.category,
      this.id,
      required this.title,
      required this.description,
      required this.date,
      this.isCompleted = false});

  //IMPLEMENTAR METODO COPYWITH PARA ATUALIZAR PROPIEDADES:
  Note2 copyWith({
    String? title,
    String? description,
    String? date,
    NoteCategory? category,
    bool? isCompleted,
  }) {
    return Note2(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
