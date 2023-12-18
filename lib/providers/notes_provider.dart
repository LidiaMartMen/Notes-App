
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';


//CREAMOS EL STATE:
class NoteState {

  final String title;
  final String description;

  //final NoteCategory category; //TODO

  NoteState({
    this.title = '',
    this.description = '',
  });

  //CREAMOS EL COPYWITH PARA CREAR UNA COPIA DEL ESTADO:
  NoteState copyWith({
    String? title,
    String? description,
  }) =>
      NoteState(
          title: title ?? this.title,
          description: description ?? this.description,
          );
}

//NOTIFIER:
class NotesNotifier extends StateNotifier<List<Note2>> {
  NotesNotifier() : super([]);

//MÉTODO:
  void addNote(Note2 note) {
    state = [...state, note];
  }
}

//PROVIDER:
final notesProvider = StateNotifierProvider<NotesNotifier, List<Note2>>((ref) => NotesNotifier());
