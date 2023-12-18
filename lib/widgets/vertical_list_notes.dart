import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/Note.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class VerticalListNotes extends ConsumerWidget {
  const VerticalListNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Note> notes = ref.watch(notesProvider);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NotesCard(notas: [
            Nota(
              id: 1,
              title: noteForm.title,
              description: noteForm.description,
              date: noteForm.date,
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
          NotesCard(
            notas: [
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
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              hoverColor: context.colorScheme.tertiary,
              foregroundColor: Colors.white,
              backgroundColor: context.colorScheme.primary,
              onPressed: () {
                context.push('/new-note');
              },
              child: Text(
                'Nueva nota',
                style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
