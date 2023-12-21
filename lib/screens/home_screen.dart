import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/bottom_menu.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    //TODO: GUARDAR NOTAS POR USUARIO CON SHARED PREFERENCES

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: deviceSize.height * 0.25,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          
                          FloatingActionButton.small(
                              child: const Icon(Icons.logout_outlined),
                              onPressed: () {
                                context.go('/login');
                              }),
                        ],
                      ),
                    ),
                    Text(
                      '13 Dic 2023',
                      style: context.textTheme.titleSmall
                          ?.copyWith(color: colors.surface),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'NOTAS',
                      style: context.textTheme.titleLarge
                          ?.copyWith(color: colors.surface),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 400,
            height: 550,
            child: VerticalListNotes(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}
