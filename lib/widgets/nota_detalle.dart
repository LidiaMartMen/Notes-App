import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/Note.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class NotaDetalle extends ConsumerWidget {
  final Note note;
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
                    style: context.textTheme.bodyLarge,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 40,
                  ),
                  // Icon(
                  //   note.category.icon,
                  //   size: 80,
                  //   color: nota.category.color,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Título: ${note.title}',
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descripción: ${note.description}',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '',
                    style: context.textTheme.bodyMedium,
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
