import 'package:flutter/material.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class Notes extends StatelessWidget {

  final String title;
  final String date;
  final IconData icon;
  const Notes({super.key, required this.icon, required this.title, required this.date});

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
          Icon(icon),
          
          Text(title),
          Text(date),
        ],
      ),
    );
  }
}
