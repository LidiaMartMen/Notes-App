import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class NotaDetalle extends ConsumerWidget {
  final Note2 note;
  const NotaDetalle({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Detalles',
                    style: context.textTheme.titleSmall,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Icon(
                    note.category?.icon,
                    size: 60,
                    color: note.category?.color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Título: ${note.title}',
                    style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Descripción: ${note.description}',
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Fecha: ${note.date}',
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Completado: ${note.isCompleted ? 'SI' : 'NO'}',
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                      mini: false,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      hoverColor: context.colorScheme.tertiary,
                      foregroundColor: Colors.white,
                      backgroundColor: context.colorScheme.primary,
                      onPressed: () {
                        final selectedNote = note;
                        //Guardar la selección en el state:
                        ref.read(notesProvider.notifier).saveSelectedNote(selectedNote);
                        //Ir a new-note
                        context.push('/edit-note');
                      },
                      child: Text(
                        'Editar',
                        style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
