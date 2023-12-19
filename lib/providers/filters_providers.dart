

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';

//Enumeración filtros posibles:
enum NoteListFilter {
  all,
  active,
  completed,
}

// La lista de todas las notas:
final noteListFilter = StateProvider((_) => NoteListFilter.all);

/// Aplicando los filtros [NoteListFilter]. Con un Provider sencillo ya que sólo queremos que filtre, no modifique el state.
final filteredNotes = Provider<List<Note2>>((ref) {
  final filter = ref.watch(noteListFilter);
  final notes = ref.watch(notesProvider);

  switch (filter) {
    case noteListFilter.completed:
      return notes.where((note) => note.isCompleted).toList();
    case noteListFilter.active:
      return notes.where((note) => !note.isCompleted).toList();
    case NoteListFilter.all: //devuelve todas las notas
      return notes;
  }
});