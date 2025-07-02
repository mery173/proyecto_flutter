import 'package:flutter/material.dart';

class SobreNosotrosScreen extends StatelessWidget {
  const SobreNosotrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre nosotros')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Somos una tienda comprometida en ofrecer la mejor experiencia de compra en línea. ¡Gracias por visitarnos!',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
