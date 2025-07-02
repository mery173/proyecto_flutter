import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre nosotros',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('Somos una tienda virtual comprometida con ofrecerte los mejores productos al mejor precio.'),
          const SizedBox(height: 16),
          const Text(
            'Contacto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('Correo: soporte@tu-tienda.com'),
          const Text('Teléfono: +51 999 999 999'),
          const SizedBox(height: 16),
          const Text(
            'Síguenos',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.facebook, size: 28, color: Colors.blueAccent),
              SizedBox(width: 10),
              SizedBox(width: 10),
              Icon(Icons.tiktok, size: 28, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}
