import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/date_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNewNoteScreen extends ConsumerWidget {
  const CreateNewNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final DateTime date = ref.watch(dateProvider);

    return SizedBox(
      child: Scaffold(
        body: SingleChildScrollView(
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
                    const OutlinedTextField(
                      title: 'Título',
                      hintText: 'Escriba el título de la nota aquí',
                      controller: null,
                      //onChangeFunction: (ref) => Helpers.selectDate(context, ref),
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
                    const OutlinedTextField(
                      maxLines: 3,
                      title: 'Descripción',
                      hintText: 'Escriba la descripción',
                      controller: null,
                      //onChangeFunction: (ref) => Helpers.selectDate(context, ref),
                    ),
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
                          context.push('/');
                          //TODO: GUARDAR NUEVA NOTA
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
          ),
        ),
      ),
    );
  }
}

class OutlinedTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController?
      controller; //CONTROLA EL TEXTO QUE SE VA ESCRIBIENDO;
  final int? maxLines; //nNUMERO MAXIMO LÍNEAS QUE OCUPA EL TEXTO
  final String? onChangeFunction;

  const OutlinedTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.onChangeFunction,
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
      onChanged: (ref) => onChangeFunction,
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
          const Spacer(),
          SizedBox(
            width: 500,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: false,
              itemBuilder: (context, index) {
                //final category = categories[index];
          
                return Container(
                  width: 50,
                  height: 50,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red.withOpacity(0.2)),
                  child: const Icon(Icons.abc),
                );
              },
              itemCount: 3,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 8,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
