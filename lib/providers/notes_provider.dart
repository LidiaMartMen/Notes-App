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
  Note2? selectedNote; //nota seleccionada
  
  NotesNotifier() : super([]);

//MÉTODO COMPROBAR FORMULARIO VÁLIDO:
  String? isValidNote(Note2 note) {
    if (note.title.trim().isEmpty ||
        note.description.trim().isEmpty ||
        note.category == null) {
      return "Todos los campos son obligatorios";
    }
    return null; //La nota SI es válida
  }

//MÉTODO AÑADIR NOTA: Añadimos condición de que sólo se añada la nueva nota si el formulario es válido:
  String addNote(Note2 note) {
    if (isValidNote(note) == null) {
      state = [...state, note];
      return "La nota es válida";
    } else {
      return "Todos los campos son obligatorios";
    }
  }

  //MÉTODO ACTUALIZAR NOTA:
  void updateNote(Note2 noteToUpdate) {
    final newState = [...state];
    final noteReplaceIndex = state.indexWhere((note) => note.title == noteToUpdate.title);

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

  //MÉTODO BORRAR NOTA:
  void deleteNote(String title) {
    //Generar un nuevo estado con todas las notas menos la que su título sea igual al que quiero borrar:
    state = state.where((note) => note.title != title).toList();
  }

  //GUARDAR NOTA SELECCIONADA:
  void saveSelectedNote(Note2 note) {
    selectedNote = note;
  }

  //MËTODO OBTENER LA NOTA SELECCIONADA:
  Note2? getSelectedNote() {
    return selectedNote;
  }

  // //MÉTODO ACTUALIZAR NOTA EXISTENTE:
  void editNote(Note2 updatedNote) {
    //Actualizar nota editada:
    if (selectedNote != null) {
      state = state.map((note) => note == selectedNote ? updatedNote : note).toList();
      selectedNote = null;
    }
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
