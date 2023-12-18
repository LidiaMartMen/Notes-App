import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/Note.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class NotesCard extends ConsumerWidget {


  final bool isCompleted;

  const NotesCard( {super.key, this.isCompleted = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Note> notes = ref.watch((notesProvider));

    var emptyNoteDashboard =
        isCompleted ? 'No hay notas' : 'No hay notas completadas';

    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Column(
      children: [
        Container(
          width: deviceSize.width,
          height: deviceSize.height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors.primaryContainer),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: notes.isEmpty
                ? Center(
                    child: Text(
                      emptyNoteDashboard,
                      style: context.textTheme.bodySmall,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      final note = notes[index];

                      return InkWell(
                        //TODO: deslizar izq para borrar nota:

                        onTap: () async {
                          //Mostrar detalles Nota
                          await showModalBottomSheet(
                              backgroundColor: context.scaffolColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (context) {
                                return NotaDetalle(
                                  note: note,
                                );
                              });
                        },
                        child: Notes(
                          //AÑADIR ICONO DE NOTA COMPLETADA
                          title: note.title,
                          description: note.description,
                        ),
                      );
                    },
                    itemCount: notes.length,
                    //AÑADIR UNA LÍNEA ENTRE NOTAS, CAMBIO EL LISTVIEW.BUILDER POR SEPARATED:
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}
