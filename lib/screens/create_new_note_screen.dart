import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/constantes.dart';

import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/utils/helpers.dart';
import 'package:notes_app_riverpod/widgets/select_category.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class CreateNewNoteScreen extends ConsumerStatefulWidget {
  const CreateNewNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  CreateNewNoteScreenState createState() => CreateNewNoteScreenState();
}

class CreateNewNoteScreenState extends ConsumerState<CreateNewNoteScreen> {
  //DECLARAR LOS CONTROLADORES DE TEXTO:
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  NoteCategory? selectedCategory;

  // @override
  // void initState() {
  //   super.initState();
  //   titleController.text = widget.note.title;
  //   descriptionController.text = widget.note.description;
  //   dateController.text = Helpers.dateFormatter(ref.read(
  //       dateProvider)); //inicializado con la fecha actual del dateProvider
  // }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BuildNoteForm(
              titleController: titleController,
              descriptionController: descriptionController,
              dateController: dateController,
              selectedCategory: selectedCategory,
              categories: categories, 
              titleScreen: 'NOTA NUEVA',
            ),
          ),
        ),
      ),
    );
  }
}

class BuildNoteForm extends ConsumerWidget {
  final List<NoteCategory> categories;

  const BuildNoteForm({
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

    return Column(
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
                height: 30,
              ),
              FloatingActionButton(
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
                          content: Text('Nota agregada correctamente')));
                      //GUARDAR LA NOTA EN EL STATE DEL PROVIDER:
                      ref.read(notesProvider.notifier).addNote(Note2(
                          category: selectedCategory,
                          isCompleted: false,
                          date: dateController.text,
                          title: titleController.text,
                          description: descriptionController.text));

                      //BORRAR LOS CAMPOS DE TEXTO DEL FORM:
                      clearForm(
                          titleController: titleController,
                          descriptionController: descriptionController,
                          dateController: dateController,
                          selectedCategory: selectedCategory,
                          categories: categories);

                      //NAVEGACIÓN A LA PANTALLA PRINCIPAL
                      context.push('/home-screen');
                    }
                  },
                  child: Text('GUARDAR NOTA',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ),
        ),
      ],
    );
  }
}
