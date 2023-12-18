import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    ///* NEW NOTE
    GoRoute(
      path: '/new-note',
      builder: (context, state) {
        // Obtén el parámetro 'note' de state.params
        final Map<String, dynamic>? params =
            state.extra as Map<String, dynamic>?;
     
        final Note2 newNote = params?['note'] as Note2;
        return CreateNewNoteScreen(note: newNote);
      },
    ),
  ],
);
