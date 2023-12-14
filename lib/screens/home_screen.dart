import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';
import 'package:notes_app_riverpod/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: deviceSize.height * 0.3,
                  width: deviceSize.width,
                  color: colors.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                      Text('13 Dic 2023', style: context.textTheme.titleSmall?.copyWith(color: colors.surface),),
                      const SizedBox(height: 10,),
                      Text('NOTAS', style: context.textTheme.titleLarge?.copyWith(color: colors.surface),)
                  ],),
                  
                ),
              
              ],
            ),
          
          ],
          
        ),
        const Positioned(
                  top: 180,
                  left: 0,
                  right: 0,
                  child: VerticalListNotes(),
                  
                  ),
        
        
        
      ],
    ));
  }
}