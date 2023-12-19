import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';

//CREAMOS EL STATE:
class NoteState {
  final String title;
  final String description;
  final DateTime date;
  final NoteCategory category;

  //final NoteCategory category; //TODO

  NoteState({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  //CREAMOS EL COPYWITH PARA CREAR UNA COPIA DEL ESTADO:
  NoteState copyWith({
    String? title,
    String? description,
    DateTime? date,
    NoteCategory? category,
  }) =>
      NoteState(
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        category: category ?? this.category
      );
}

//NOTIFIER:
class NotesNotifier extends StateNotifier<List<Note2>> {
  NotesNotifier() : super([]);

//MÉTODO AÑADIR NOTA:
  void addNote(Note2 note) {
    state = [...state, note];
  }
}

//METODO MANEJA LA FECHA ACTUAL, SETTEADO A CURRENT DATE AND TIME
final dateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

//PROVIDER:
final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Note2>>((ref) => NotesNotifier());
