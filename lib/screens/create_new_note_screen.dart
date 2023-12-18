import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/Note.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNewNoteScreen extends ConsumerWidget {
  final Note note;

  const CreateNewNoteScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final DateTime date = ref.watch(dateProvider);
    //Controlar cuando cambia el texto:
    TextEditingController titleController = TextEditingController(
      text: note.title,
    );

    return SizedBox(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BuildNoteForm(titleController: titleController, note: note,),
          ),
        ),
      ),
    );
  }
}

class BuildNoteForm extends ConsumerWidget {
  final Note note;
  const BuildNoteForm({
    super.key,
    required this.titleController, required this.note,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  onChangeFunctionProvider: (title) {}
                  //=> ref.read(noteProvider(nota).notifier).onTitleChanged(value),
                  ),
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
                  maxLines: 3,
                  title: 'Descripción',
                  hintText: 'Escriba la descripción',
                  controller: titleController,
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
              const OutlinedTextField(
                title: 'Fecha',
                hintText: 'Hola',
                //Helpers.dateFormatter(date),
                controller: null,
                //onChangeFunction: Helpers.selectDate(context, ref),
              ),
              const SizedBox(
                height: 10,
              ),
              const SelectCategory(categories: []),
              const SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                  hoverColor: context.colorScheme.tertiary,
                  foregroundColor: Colors.white,
                  backgroundColor: context.colorScheme.primary,
                  onPressed: () {
                    context.push('/'); //NAVEGACIÓN A LA PANTALLA PRINCIPAL
                    ref.read(notesProvider.notifier).addNote(Note(
                        title: titleController.text,
                        description: titleController.text));
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
      //TODO: FUNCIÓN PARA COGER LA FECHA DEL CALENDARIO
      onChanged:
          //onChangeFunctionDate,
          onChangeFunctionProvider,
    );
  }
}



class SelectCategory extends StatelessWidget {
  final List<NoteCategory> categories;

  const SelectCategory({super.key, required this.categories});

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
                  //final category = categories[index];
                  //TODO: AÑADIR CIRCULOS CON LAS CATEGORÍAS:
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.2)),
                    child: const Icon(Icons.abc_outlined),
                  );
                },
                itemCount: 7,
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
