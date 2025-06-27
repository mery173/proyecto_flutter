import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/carrito_provider.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double precio;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.precio,
  });

  Widget _buildImage(String url) {
    if (url.startsWith('http')) {
      return Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 60),
          ),
        ),
      );
    } else {
      return Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(url, fit: BoxFit.cover),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context, listen: false);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(imageUrl),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${precio.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color.fromARGB(255, 90, 51, 158),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 148, 148, 236),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                carrito.agregarProducto({
                  'image': imageUrl,
                  'title': title,
                  'precio': precio,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Producto agregado al carrito')),
                );
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
