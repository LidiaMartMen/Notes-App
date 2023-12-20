import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/screens/edit_note_screen.dart';
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
                        ref
                            .read(notesProvider.notifier)
                            .saveSelectedNote(selectedNote);
                        //Ir a edit-note
                        _showEditNoteScreen(context);
                      },
                      child: Text(
                        'Editar',
                        style: context.textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
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

Future<void> _showEditNoteScreen(BuildContext context) async {
  await Navigator.of(context).push(
    _createPageRoute(const EditNoteScreen()),
  );
}

PageRouteBuilder _createPageRoute(Widget page) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutQuart;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Cambiar el valor para ajustar el tamaño de la pantalla de edición
      double scale = 0.9;
      var scaledAnimation =
          Tween<double>(begin: 1.0, end: scale).animate(animation);

      return ScaleTransition(
        scale: scaledAnimation,
        child: SlideTransition(position: offsetAnimation, child: child),
      );
    },
  );
}
