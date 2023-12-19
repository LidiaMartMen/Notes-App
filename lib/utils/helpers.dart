import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_riverpod/data/entities/categories.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';

class Helpers {
  //FUNCIÓN CALENDARIO: DATE
  static Future<void> selectDate(BuildContext context, WidgetRef ref) async {
 
    final DateTime initialDate = ref
        .watch(dateProvider.notifier)
        .state; //OBTENER VALOR GUARDADO EN PROVIDER

 

    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2090));

    

//DECIRLE AL PROVIDER QUE VALOR SE HA SELECCIONADO:
    if (selectedDate != null && selectedDate != initialDate) {
      ref.read(dateProvider.notifier).state =
          selectedDate; //Actualiza el valor del provider con el nuevo día seleccionado
    }
  }

//FUNCIÓN PARA PASAR DE DATE TIME A STRING: con librería INTL
  static String dateFormatter(DateTime date) {
    try {
      return DateFormat.yMMMd().format(date);
    } catch (e) {
      return DateFormat.yMMMd().format(
        DateTime.now(),
      );
    }
  }
}

//FUNCIÓN PARA BORRAR LOS TEXTOS DEL FORMULARIO:
void clearForm({
  required TextEditingController titleController,
  required TextEditingController descriptionController,
  required TextEditingController dateController,
  required NoteCategory? selectedCategory,
  required List<NoteCategory> categories,
}) {
  titleController.text = '';
  descriptionController.text = '';
  dateController.text = '';
  selectedCategory= null;
  }
