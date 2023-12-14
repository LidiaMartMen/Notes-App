import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/config/router/app_router.dart';
import 'package:notes_app_riverpod/config/theme/app_theme.dart';
import 'package:notes_app_riverpod/screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
