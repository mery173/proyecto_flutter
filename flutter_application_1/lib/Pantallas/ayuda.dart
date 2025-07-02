import 'package:flutter/material.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '¿Necesitas ayuda? Escríbenos o revisa nuestras preguntas frecuentes.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
