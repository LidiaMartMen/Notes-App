import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
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
                    height: 40,
                  ),
                  Icon(
                    note.category?.icon,
                    size: 80,
                    color: note.category?.color,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Título: ${note.title}',
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descripción: ${note.description}',
                    style: context.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Fecha: ${note.date}',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
