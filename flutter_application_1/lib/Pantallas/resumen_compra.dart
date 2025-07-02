import 'package:flutter/material.dart';

class ResumenCompraScreen extends StatelessWidget {
  final String nombre;
  final double saldo;
  final double total;
  final List productos;

  const ResumenCompraScreen({
    super.key,
    required this.nombre,
    required this.saldo,
    required this.total,
    required this.productos,
  });

  @override
  Widget build(BuildContext context) {
    double nuevoSaldo = saldo - total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Compra'),
        backgroundColor: const Color(0xFFB3B3FF),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hola, $nombre 👋', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Saldo actual: S/ ${saldo.toStringAsFixed(2)}'),
            Text('Total de compra: S/ ${total.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Text(
              'Nuevo saldo: S/ ${nuevoSaldo.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            const Text('Productos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (_, i) {
                  final producto = productos[i];
                  return ListTile(
                    leading: producto['image'].toString().startsWith('http')
                        ? Image.network(producto['image'], width: 40, height: 40, fit: BoxFit.cover)
                        : Image.asset(producto['image'], width: 40, height: 40, fit: BoxFit.cover),
                    title: Text(producto['title']),
                    subtitle: Text('\$${producto['precio'].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: const Text('Confirmar compra'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
