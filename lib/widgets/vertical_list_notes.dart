import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class VerticalListNotes extends StatefulWidget {
  const VerticalListNotes({super.key});

  @override
  State<VerticalListNotes> createState() => _VerticalListNotesState();
}

class _VerticalListNotesState extends State<VerticalListNotes> {


    var isPressed = false;
    
  @override
  Widget build(BuildContext context) {
   

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           NotesCard(notas: [
            Nota( 
              id: 1, 
              title: 'Lidia', 
              description: 'Hacer la compra', 
              date: '12-12-2023', 
              isCompleted: false, 
              category: NoteCategory.familia,
            ),
            
            Nota( 
              id: 1, 
              title: 'Lidia2', 
              description: 'Hacer la compra', 
              date: '12-12-2023', 
              isCompleted: false, 
              category: NoteCategory.trabajo,
            ),
            Nota( 
              id: 1, 
              title: 'Lidia3', 
              description: 'Hacer la compra', 
              date: '12-12-2023', 
              isCompleted: false, 
              category: NoteCategory.educacion,
            ),
            Nota( 
              id: 1, 
              title: 'Lidia3', 
              description: 'Hacer la compra', 
              date: '12-12-2023', 
              isCompleted: false, 
              category: NoteCategory.trabajo,
            ),
            Nota( 
              id: 1, 
              title: 'Lidia3', 
              description: 'Hacer la compra', 
              date: '12-12-2023', 
              isCompleted: false, 
              category: NoteCategory.familia,
            ),
            ]),
          Text('Completadas',
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.primary)),
           NotesCard(notas: [
              Nota( 
                id: 1, 
                title: 'Lidia3', 
                description: 'Hacer la compra', 
                date: '12-12-2023', 
                isCompleted: false, 
                category: NoteCategory.familia,
              ),
              Nota( 
                id: 1, 
                title: 'Lidia3', 
                description: 'Hacer la compra', 
                date: '12-12-2023', 
                isCompleted: false, 
                category: NoteCategory.familia,
              ),
          ],),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              backgroundColor: isPressed ? context.colorScheme.primary : context.colorScheme.secondary,
              onPressed: () {
                setState(() => isPressed = !isPressed);
              },
              child: const Text(
                'Nueva nota',
              ))
        ],
      ),
    );
  }
}
