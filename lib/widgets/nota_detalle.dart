import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class NotaDetalle extends StatelessWidget {

  final Nota nota;
  const NotaDetalle({super.key, required this.nota});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Detalles', style: context.textTheme.bodyLarge,),
          const Divider(),
          const SizedBox(height: 40,),
          Icon(nota.category.icon, size: 80, color: nota.category.color,),
          const SizedBox(height: 20,),
          Text(nota.title, style: context.textTheme.bodyLarge?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Text(nota.date, style: context.textTheme.bodyMedium,),
          const SizedBox(height: 20,),
          Text(nota.description, style: context.textTheme.bodyMedium,),
          
        ],
      ) ,
      );
  }
}
