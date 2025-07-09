import 'package:flutter/material.dart';

class SobreNosotrosScreen extends StatelessWidget {
  const SobreNosotrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre nosotros')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '¿Quiénes somos?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'LooksGreat es una tienda online dedicada a ofrecer moda y accesorios de alta calidad para todos los estilos. '
              'Nuestro objetivo es que cada cliente se sienta cómodo, seguro y feliz con su compra.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Nuestra misión',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Brindar una experiencia de compra única y satisfactoria, ofreciendo productos seleccionados cuidadosamente y '
              'un servicio al cliente excepcional.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Nuestra visión',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Ser la tienda online líder en moda en Latinoamérica, reconocida por nuestra calidad, innovación y compromiso con el cliente.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Nuestros valores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '• Compromiso con la calidad\n'
              '• Pasión por la moda y la innovación\n'
              '• Atención personalizada\n'
              '• Honestidad y transparencia',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '¡Gracias por confiar en nosotros y ser parte de la familia LooksGreat!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
