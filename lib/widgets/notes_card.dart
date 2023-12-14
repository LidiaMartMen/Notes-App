import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/notes.dart';

class NotesCard extends StatelessWidget {
  final List<Nota> notas;
  final bool isCompleted;

  const NotesCard({super.key, required this.notas, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
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
            child: notas.isEmpty
                ? Center(
                    child: Text(
                      emptyNoteDashboard,
                      style: context.textTheme.bodySmall,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      final nota = notas[index];
                      return Row(
                        children: [
                          Notes(
                            icon: nota.category.icon,
                            title: nota.title,
                            date: nota.date,
                          ),
                        ],
                      );
                    },
                    itemCount: notas.length,
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
