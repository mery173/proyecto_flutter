import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/carrito_provider.dart';
import '../Providers/usuario_provider.dart';
import 'resumen_compra.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);
    final usuario = Provider.of<UsuarioProvider>(context);
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
                    subtitle: Text('\$${item['precio'].toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => carrito.eliminarProducto(i),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: productos.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      double totalCarrito = carrito.totalCarrito();

                      if (usuario.logueado) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResumenCompraScreen(
                              nombre: usuario.nombre,
                              saldo: usuario.saldo,
                              total: totalCarrito,
                              productos: carrito.carrito,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Debes iniciar sesión para comprar')),
                        );
                      }
                    },
                    icon: const Icon(Icons.shopping_bag),
                    label: const Text('Comprar'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      carrito.limpiarCarrito();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Carrito vaciado 🗑️')),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Vaciar'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
