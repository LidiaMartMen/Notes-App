import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/constantes.dart';

import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/utils/helpers.dart';

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
    return SizedBox(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BuildNoteForm(
              titleController: titleController,
              descriptionController: descriptionController,
              dateController: dateController,
              selectedCategory: selectedCategory,
              onCategorySelected: (selectedCat) {
                //Actualiza la categoría seleccionada:
                setState(() {
                  selectedCategory = selectedCat;
                });
              },
              categories: categories,
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
    required this.selectedCategory,
    required this.onCategorySelected,
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.categories,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final NoteCategory? selectedCategory;
  final Function(NoteCategory) onCategorySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    DateTime? selectedDate = ref.watch(dateProvider);


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
                'NOTA NUEVA',
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
                  child: 
                  Text(
                    selectedDate == null || selectedDate == DateTime.now()
                    ? 'Seleccione la fecha'
                    : 'Fecha seleccionada: ${Helpers.dateFormatter(selectedDate)}'
                    , style: context.textTheme.titleSmall?.copyWith(
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
                onCategorySelected: onCategorySelected,
              ),
              const SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                  hoverColor: context.colorScheme.tertiary,
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primary,
                  onPressed: () {
                    context.push('/'); //NAVEGACIÓN A LA PANTALLA PRINCIPAL
                    //GUARDAR LA NOTA EN EL STATE DEL PROVIDER:
                    ref.read(notesProvider.notifier).addNote(Note2(
                        category: selectedCategory,
                        isCompleted: true,
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

class OutlinedTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController?
      controller; //CONTROLA EL TEXTO QUE SE VA ESCRIBIENDO;
  final int? maxLines; //nNUMERO MAXIMO LÍNEAS QUE OCUPA EL TEXTO
  final Function(String)? onChangeFunctionDate;
  final Function(String)? onChangeFunctionProvider;

  const OutlinedTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.onChangeFunctionDate,
    this.onChangeFunctionProvider,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: controller, //controlar el texto escrito
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      }, //PARA QUITAR EL FOCO
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.clear),
        labelText: title,
        labelStyle: context.textTheme.titleSmall,
        hintText: hintText,
        helperStyle: context.textTheme.titleSmall,
        hintStyle: context.textTheme.bodySmall,
        border: const OutlineInputBorder(),
      ),

      onChanged: onChangeFunctionProvider,
    );
  }
}

class SelectCategory extends StatelessWidget {
  final List<NoteCategory> categories;

  final Function(NoteCategory) onCategorySelected;

  const SelectCategory(
      {super.key, required this.categories, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Text(
            'Category',
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return GestureDetector(
                    onTap: () {
                      onCategorySelected(category);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category.color.withOpacity(0.2)),
                      child: Icon(category.icon),
                    ),
                  );
                },
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
