import 'package:flutter/material.dart';

class Helpers {

  //FUNCIÓN CALENDARIO: DATE
  static void selectDate(context, ref) async {
    DateTime fechaSeleccionada = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
  }
}
