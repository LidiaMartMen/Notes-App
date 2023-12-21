import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/screens/edit_note_screen.dart';
import 'package:notes_app_riverpod/screens/screens.dart';



final appRouter = GoRouter(
  initialLocation: '/register',
  routes: [
     ///*REGISTER:
     GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    ///*LOGIN:
     GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/home-screen',
      builder: (context, state) => const HomeScreen(),
    ),

    ///* NEW NOTE
    GoRoute(
      path: '/new-note',
      builder: (context, state) {
        return const CreateNewNoteScreen();
      },
    ),
     ///* EDIT NOTE
    GoRoute(
      path: '/edit-note',
      builder: (context, state) {
        return const EditNoteScreen();
      },
    ),
  ],
);
