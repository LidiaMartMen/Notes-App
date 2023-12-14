

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class CreateNewNoteScreen extends StatelessWidget {
  const CreateNewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        body: Column(
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
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
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
                    hintText: 'Elija la fecha',
                    controller: null,
                  ),
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
                      child: Text(
                        'GUARDAR NOTA', style: context.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold,
                      ))
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutlinedTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller; //CONTROLA EL TEXTO QUE SE VA ESCRIBIENDO;
  final int? maxLines; //nNUMERO MAXIMO LÍNEAS QUE OCUPA EL TEXTO

  const OutlinedTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
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
        labelText: title, labelStyle: context.textTheme.titleSmall,
        hintText: hintText, helperStyle: context.textTheme.titleSmall,
        hintStyle: context.textTheme.bodySmall,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        return;
      },
    );
  }
}
