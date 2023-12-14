import 'package:flutter/material.dart';

enum NoteCategory {
  //ENUMERACIÓN:
  trabajo(Icons.work, Color.fromARGB(255, 4, 93, 166)),
  personal(Icons.person, Color.fromRGBO(255, 4, 93, 166)),
  educacion(Icons.school, Color.fromRGBO(79, 126, 72, 0.996)),
  familia(Icons.family_restroom, Color.fromRGBO(229, 188, 42, 1));

  final IconData icon;
  final Color color;

  //CONSTRUCTOR
  const NoteCategory(this.icon, this.color);
}
