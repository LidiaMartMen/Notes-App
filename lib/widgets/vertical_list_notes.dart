import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class VerticalListNotes extends ConsumerWidget {
  const VerticalListNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   


    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(child: NotesCard()),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: 'New note',
                hoverColor: context.colorScheme.tertiary,
                foregroundColor: Colors.white,
                backgroundColor: context.colorScheme.primary,
                onPressed: () {
                  context.go('/new-note'); //Ir a new-note
                },
                child: Text(
                  'Nueva nota',
                  style: context.textTheme.titleSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
