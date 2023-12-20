import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';

const List<NoteCategory> categories = [
  NoteCategory('Trabajo', Icons.work, Colors.blue),
  NoteCategory('Familia', Icons.family_restroom, Colors.pink),
  NoteCategory('Personal', Icons.person, Color.fromARGB(255, 255, 108, 59)),
  NoteCategory('Público', Icons.public, Colors.green),
];
