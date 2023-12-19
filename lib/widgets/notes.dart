import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/providers/notes_provider.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class Notes extends ConsumerWidget {
  final Note2 note;

  final bool isCompleted;
  final String date;
  final Color colorIcon;
  final String title;
  final String description;
  final IconData icon;
  const Notes( 
      {required this.note,
        required this.isCompleted,
      required this.date,
      super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.colorIcon});

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
            icon,
            color: colorIcon,
          ),
          const Spacer(),
          Text(
            title,
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(date),
          Checkbox(
              value: note.isCompleted,
              onChanged: (value) {
                ref
                    .read(notesProvider.notifier)
                    .updateNote(note.title);
              },
              activeColor:  colors.primary,
              checkColor: Colors.white,
              )
        ],
      ),
    );
  }
}
