import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';

//CREAMOS EL STATE:
class NoteState {
  final String title;
  final String description;
  final DateTime date;
  final NoteCategory category;
  final bool? isCompleted;

  NoteState({
    this.isCompleted = false, //NO COMPLETADA
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  //CREAMOS EL COPYWITH PARA CREAR UNA COPIA DEL ESTADO:
  NoteState copyWith({
    bool? isCompleted,
    String? title,
    String? description,
    DateTime? date,
    NoteCategory? category,
  }) =>
      NoteState(
          isCompleted: isCompleted ?? this.isCompleted,
          title: title ?? this.title,
          description: description ?? this.description,
          date: date ?? this.date,
          category: category ?? this.category);
}

//NOTIFIER:
class NotesNotifier extends StateNotifier<List<Note2>> {
  NotesNotifier() : super([]);

//MÉTODO AÑADIR NOTA:
  void addNote(Note2 note) {
    state = [...state, note];
  }

  //MÉTODO ACTUALIZAR NOTA por ID:
  void updateNote(String title) {
    final newState = [...state];
    final noteReplaceIndex = state.indexWhere((note) => note.title == title);

    //Ver si existe el título del index en la lista de notas:
    if (noteReplaceIndex != -1) {
      newState[noteReplaceIndex] = Note2(
          category: newState[noteReplaceIndex].category,
          title: newState[noteReplaceIndex].title,
          description: newState[noteReplaceIndex].description,
          date: newState[noteReplaceIndex].date,
          isCompleted: !newState[noteReplaceIndex].isCompleted);
    }
    state = newState;
  }
}

//METODO MANEJA LA FECHA ACTUAL, SETTEADO A CURRENT DATE AND TIME
final dateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

//MÉTODO PARA GUARDAR LA CATEGORÍA SELECCIONADA:
final selectedCategoryProvider = StateProvider<NoteCategory?>((ref) => null);

//PROVIDER:
final notesProvider =
    StateNotifierProvider<NotesNotifier, List<Note2>>((ref) => NotesNotifier());


