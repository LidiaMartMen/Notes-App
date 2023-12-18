//STATE - NOTIFIER - PROVIDER:

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';

//CREAMOS EL STATE:
class NoteState {
  // final bool isValid;
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final bool isLoading;
  //final NoteCategory category; //TODO

  NoteState({
    this.isLoading = true, 
    // this.isValid = false,
    this.id,
    this.title = '',
    this.description = '',
    this.date = '',
    this.isCompleted = false,
    //this.category =  //todo
  });

  //CREAMOS EL COPYWITH PARA CREAR UNA COPIA DEL ESTADO:
  NoteState copyWith({
    bool? isLoading,
    // bool? isValid,
    int? id,
    String? title,
    String? description,
    String? date,
    bool? isCompleted,
    //this.category =  //todo
  }) =>
      NoteState(
          isLoading: isLoading ?? this.isLoading,
          //isValid: isValid ?? this.isValid, //TODO
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          date: date ?? this.date,
          isCompleted: isCompleted ?? this.isCompleted
          //this.category =  //todo
          );
}

//CREAMOS EL NOTIFIER: mantener el estado y sus cambios y emitir los datos nuevos.

class NoteNotifier extends StateNotifier<NoteState> {
//Llama esta función cuando hago click en "GUARDAR NOTA", mandar la información y validar el formulario:
//NoteLike: la función devuelve algo parecido a una nota:
  final Future<bool> Function(Map<String, dynamic> noteLike)? onSubmitCallback;

//CONSTRUCTOR:
  NoteNotifier({
    this.onSubmitCallback,
    required Nota nota,
  }) : super(
            //en el super creamos el estado inicial del NoteState con nuestra entidad de NOTA:
            NoteState(
          id: nota.id,
          title: nota.title,
          description: nota.description,
          date: nota.date,
          isCompleted: nota.isCompleted,
          //this.category =  //todo
        ));

  //FUNCIONES PARA ACTUALIZAR LOS VALORES:
  void onTitleChanged(String title) {
    state = state.copyWith(title: title);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onDateCHanges(String date) {
    state = state.copyWith(date: date);
  }

  void onIsCompletedChanged(bool isCompleted) {
    state = state.copyWith(isCompleted: isCompleted);
  }

  Future<bool> onNoteSubmit() async {
    final noteLike = {
      'id': state.id,
      'title': state.title,
      'description': state.description,
      'date': state.date,
      'isCompleted': state.isCompleted,
    };
    try {
      return await onSubmitCallback!(noteLike);
    } catch (e) {
      return false;
    }
  }
}

//CREAMOS EL PROVIDER:
//autodispose: para que cuando salgas del form vuelva a blanco todo:

final noteProvider = StateNotifierProvider.autoDispose
    .family<NoteNotifier, NoteState, Nota>((ref, nota) {
  //TODO: CREATE UPDATE CALLBACK

  return NoteNotifier(
    nota: nota,

    //TODO: ONSUBMITCALLBACK:
  );
});
