import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/carrito_provider.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    final productos = carrito.carrito;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3B3FF),
      ),
      body: productos.isEmpty
          ? const Center(
              child: Text(
                "Tu carrito está vacío 🛒",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: productos.length,
              itemBuilder: (_, i) {
                final item = productos[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: item['image'].toString().startsWith('http')
                        ? Image.network(item['image'], width: 50, height: 50)
                        : Image.asset(item['image'], width: 50, height: 50),
                    title: Text(item['title']),
                    subtitle:
                        Text('\$${item['precio'].toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => carrito.eliminarProducto(i),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: productos.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                carrito.limpiarCarrito();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Carrito vaciado 🗑️')),
                );
              },
              label: const Text('Vaciar carrito'),
              icon: const Icon(Icons.delete),
              backgroundColor: Colors.red,
            )
          : null,
    );
  }
}
