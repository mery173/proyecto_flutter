import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/carrito_provider.dart';
import '../Providers/usuario_provider.dart';
import '../Ventanas/login.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double precio;
  final VoidCallback? onAdd; // Callback opcional para acciones extra

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.precio,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context, listen: false);
    final usuario = Provider.of<UsuarioProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'S/ ${precio.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 63, 63, 63),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 77, 77),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (!usuario.logueado) {
                        // Si no ha iniciado sesión, muestra el diálogo
                        showDialog(
                          context: context,
                          builder: (_) => const DialogLogin(),
                        );
                        return;
                      }

                      // Usuario logueado: agregar al carrito
                      carrito.agregarProducto({
                        'image': imageUrl,
                        'title': title,
                        'precio': precio,
                      });

                      // Ejecutar callback adicional si se definió
                      if (onAdd != null) {
                        onAdd!();
                      }

                      // Mostrar mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Producto agregado al carrito'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Agregar',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
