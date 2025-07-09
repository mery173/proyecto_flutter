import 'package:flutter/material.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayuda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Necesitas ayuda?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estamos aquí para ayudarte. Revisa nuestras preguntas frecuentes o contáctanos directamente.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Preguntas frecuentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('• ¿Cómo puedo seguir mi pedido?'),
            const Text(
                'Puedes revisar el estado de tu compra en la sección "Mis Pedidos" de tu cuenta.'),
            const SizedBox(height: 10),
            const Text('• ¿Cuáles son los métodos de pago disponibles?'),
            const Text(
                'Aceptamos pagos con tarjeta de crédito, débito y Yape.'),
            const SizedBox(height: 10),
            const Text('• ¿Puedo devolver un producto?'),
            const Text(
                'Sí, tienes hasta 7 días después de recibir tu pedido para solicitar un cambio o devolución.'),
            const SizedBox(height: 10),
            const Text('• ¿Cómo me comunico con atención al cliente?'),
            const Text(
                'Puedes escribirnos al correo soporte@looksgreat.com o enviarnos un mensaje a nuestro WhatsApp.'),
            const SizedBox(height: 20),
            const Text(
              'Contacto directo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Correo: soporte@looksgreat.com'),
            const Text('WhatsApp: +51 912 345 678'),
            const Text('Horario de atención: Lunes a sábado, 9:00 am - 6:00 pm'),
            const SizedBox(height: 20),
            const Text(
              'Recomendaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
                '• Revisa bien las tallas antes de realizar tu pedido.\n• Verifica tus datos personales y dirección de entrega.\n• Guarda tu número de pedido para cualquier consulta posterior.'),
          ],
        ),
      ),
    );
  }
}
