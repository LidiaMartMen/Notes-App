import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class Notes extends StatelessWidget {
  final Color colorIcon;
  final String title;
  final String date;
  final IconData icon;
  const Notes({super.key, required this.icon, required this.title, required this.date, required this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.colorScheme.primary,
          width: 2,
        )
      ),
      child: Row(
        children: [
          Icon(icon, color: colorIcon,),
          const Spacer(),
          Text(title, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold), ),
          const SizedBox(width: 20,),
          Text(date),
        ],
      ),
    );
  }
}
