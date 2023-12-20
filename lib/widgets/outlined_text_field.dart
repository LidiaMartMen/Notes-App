
import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

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
        suffixIcon: GestureDetector(
            onTap: () {
              //Borrar el texto cuando toco la X:
              controller?.clear();
            },
            child: const Icon(Icons.clear)),
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
