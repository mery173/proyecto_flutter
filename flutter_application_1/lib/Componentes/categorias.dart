import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap; // <-- NUEVO

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap, // <-- NUEVO
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <-- NUEVO
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 190, 190, 190),
            child: Icon(icon, color: const Color.fromARGB(255, 78, 78, 78)),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}
