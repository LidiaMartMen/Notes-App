import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/filters_providers.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class NotesCard extends ConsumerWidget {
  final bool isCompleted;

  const NotesCard({super.key, this.isCompleted = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Obtengo las notas de la lista según el filtro actual:
    final List<Note2> notesFiltered = ref.watch(filteredNotes);

    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Column(
      children: [
        Container(
          width: deviceSize.width,
          height: deviceSize.height * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors.primaryContainer),
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final note = notesFiltered[index];

              return Dismissible(
                key: Key(note.title),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: const Color.fromARGB(255, 250, 132, 124),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  //Añadir función en provider de eliminar la nota al deslizar
                  ref.read(notesProvider.notifier).deleteNote(note.title);
                },
                child: InkWell(
                  onTap: () async {
                    //Mostrar detalles Nota
                    await showModalBottomSheet(
                        backgroundColor: context.scaffolColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (context) {
                          return NotaDetalle(
                            note: note,
                          );
                        });
                  },
                  child: Notes(
                    title: note.title,
                    description: note.description,
                    date: note.date,
                    icon: note.category?.icon ?? Icons.error,
                    colorIcon: note.category?.color ?? Colors.transparent,
                    isCompleted: note.isCompleted,
                    note: note,
                  ),
                ),
              );
            },
            itemCount: notesFiltered.length,
            //AÑADIR UNA LÍNEA ENTRE NOTAS, CAMBIO EL LISTVIEW.BUILDER POR SEPARATED:
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
        )
      ],
    );
  }
}
