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
            backgroundColor: const Color.fromARGB(255, 181, 181, 224),
            child: Icon(icon, color: const Color.fromARGB(255, 75, 47, 122)),
          ),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}
