import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/providers/filters_providers.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      //Leer el gestor de estado de los filtros:
    final filter = ref.watch(noteListFilter);
      //Dar un index a cada caso:
      int currentIndex() {
      switch (filter) {
        case NoteListFilter.completed:
          return 2;
        case NoteListFilter.active:
          return 1;
        case NoteListFilter.all:
          return 0;
      }
    }

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      onTap: (index){
         if (index == 0) ref.read(noteListFilter.notifier).state = NoteListFilter.all;
        if (index == 1) ref.read(noteListFilter.notifier).state = NoteListFilter.active;
        if (index == 2) ref.read(noteListFilter.notifier).state = NoteListFilter.completed;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.list), label: 'Todas', tooltip: 'Todas'),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'Activas',
          tooltip: 'Activas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Completadas',
          tooltip: 'Completadas',
        ),
      ],
      currentIndex: currentIndex(),
      selectedItemColor: colors.primary,
    );
  }
}
