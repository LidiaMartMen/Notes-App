import 'package:go_router/go_router.dart';

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
        return const CreateNewNoteScreen();
      },
    ),
  ],
);
