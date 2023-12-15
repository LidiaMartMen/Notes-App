import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/providers/date_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:intl/intl.dart';

class Helpers {
  //FUNCIÓN CALENDARIO: DATE
  static void selectDate(BuildContext context, ref) async {
    final DateTime initialDate = ref.watch<StateProvider>(dateProvider);

    DateTime? fechaSeleccionada = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2090));

//DECIRLE AL PROVIDER QUE VALOR SE HA SELECCIONADO:
    if (fechaSeleccionada != null) {
      fechaSeleccionada = ref.read(dateProvider.notifier).state;
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
