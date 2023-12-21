import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/constantes.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/utils/helpers.dart';
import 'package:notes_app_riverpod/widgets/select_category.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class EditNoteScreen extends ConsumerWidget {
  const EditNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    //Acceder a la nota seleccionada desde el provider:
    final selectedNote = ref.watch(notesProvider.notifier).getSelectedNote();

    final selectedCategory = ref.watch(selectedCategoryProvider);

    //Inicializar controladores de texto con los valores de selectedNote:
    final TextEditingController titleController =
        TextEditingController(text: selectedNote?.title);
    final TextEditingController descriptionController =
        TextEditingController(text: selectedNote?.description);
    final TextEditingController dateController =
        TextEditingController(text: selectedNote?.date);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: colors.primary,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BuildEditNoteForm(
            titleController: titleController,
            descriptionController: descriptionController,
            dateController: dateController,
            selectedCategory: selectedCategory,
            categories: categories,
            titleScreen: 'EDITAR NOTA',
          ),
        ),
      ),
    );
  }
}

class BuildEditNoteForm extends ConsumerWidget {
  final List<NoteCategory> categories;

  const BuildEditNoteForm({
    required this.titleScreen,
    required this.selectedCategory,
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.categories,
  });
  final String titleScreen;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final NoteCategory? selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? selectedDate = ref.watch(dateProvider);
    final NoteCategory? selectedCategory =
        ref.watch(selectedCategoryProvider.notifier).state;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: context.deviceSize.height * 0.2,
            width: context.deviceSize.width,
            color: context.colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleScreen,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Título',
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedTextField(
                    title: 'Título',
                    hintText: 'Escriba el título de la nota aquí',
                    controller:
                        titleController, //OBSERVA CUANDO SE ESCRIBE ALGO AQUÍ
                    onChangeFunctionProvider: (title) {}),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Descripción',
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedTextField(
                    maxLines: 2,
                    title: 'Descripción',
                    hintText: 'Escriba la descripción',
                    controller: descriptionController,
                    onChangeFunctionProvider: (description) {}),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Fecha',
                  style: context.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            context.colorScheme.primary),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text(
                        selectedDate == null || selectedDate == DateTime.now()
                            ? 'Seleccione la fecha'
                            : 'Fecha seleccionada: ${Helpers.dateFormatter(selectedDate)}',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () async {
                      //Selecciona la fecha:
                      await Helpers.selectDate(context, ref);
                      //Actualiza el controlador de texto:
                      dateController.text =
                          Helpers.dateFormatter(ref.read(dateProvider));
                    }),
                const SizedBox(
                  height: 10,
                ),
                SelectCategory(
                  categories: categories,
                ),
                const SizedBox(
                  height: 20,
                ),
                FloatingActionButton(
                  heroTag: 'guardar',
                    hoverColor: context.colorScheme.tertiary,
                    foregroundColor: Colors.white,
                    backgroundColor: context.colorScheme.primary,
                    onPressed: () {
                      //Comprobar si la nota es válida:
                      final isValidNote = ref
                          .read(notesProvider.notifier)
                          .isValidNote(Note2(
                              category: selectedCategory,
                              isCompleted: false,
                              date: dateController.text,
                              title: titleController.text,
                              description: descriptionController.text));
    
                      //MOSTRAR SNACKBAR CON EL MENSAJE DE VALIDACIÓN:
                      if (isValidNote != null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Todos los campos son obligatorios')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Nota modificada correctamente')));
    
                        // Obtener la nota actualizada con los nuevos valores
                        final updatedNote = Note2(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: dateController.text,
                          category: selectedCategory,
                          isCompleted: false,
                        );
    
                        //Editar la nota existente:
                        ref.read(notesProvider.notifier).editNote(updatedNote);
    
                        //NAVEGACIÓN A LA PANTALLA PRINCIPAL
                        context.push('/home-screen');
                      }
                    },
                    child: Text('GUARDAR NOTA EDITADA',
                        style: context.textTheme.titleSmall?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
                        const SizedBox(
                  height: 10,
                ),
                FloatingActionButton.small(
                  heroTag: 'salir',
                  backgroundColor: context.colorScheme.primary,
                  onPressed: () {
                    context.push('/');
                  },
                  child: Text('SALIR',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
