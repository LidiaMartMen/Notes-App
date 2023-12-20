import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class Notes extends ConsumerWidget {
  final Note2 note;

  const Notes({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.colorScheme.primary,
            width: 2,
          )),
      child: Row(
        children: [
          Icon(
            note.category?.icon ?? Icons.error,
            color:  note.category?.color ?? Colors.transparent,
          ),
          const Spacer(),
          Text(
            note.title,
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(note.date),
          Checkbox(
            value: note.isCompleted,
            onChanged: (value) {
              ref.read(notesProvider.notifier).updateNote(note.title);
            },
            activeColor: colors.primary,
            checkColor: Colors.white,
          )
        ],
      ),
    );
  }
}
