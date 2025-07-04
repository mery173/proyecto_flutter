import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Componentes/producto.dart';
import '../Pantallas/carrito.dart';

class CaballerosScreen extends StatefulWidget {
  const CaballerosScreen({super.key});
  @override
  State<CaballerosScreen> createState() => _CaballerosScreenState();
}

class _CaballerosScreenState extends State<CaballerosScreen> {
  List productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarProductosCaballeros();
  }

  Future<void> cargarProductosCaballeros() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products'),
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);

        // Filtrar por palabras clave relacionadas con hombre
        data = data.where((producto) {
          final title = producto['title'].toString().toLowerCase();
          final description = producto['description'].toString().toLowerCase();

          return (title.contains('man') ||
                  title.contains('men') ||
                  title.contains('male') ||
                  title.contains('shirt') ||
                  title.contains('t-shirt') ||
                  title.contains('hoodie') ||
                  title.contains('pants') ||
                  description.contains('man') ||
                  description.contains('men') ||
                  description.contains('male') ||
                  description.contains('shirt') ||
                  description.contains('t-shirt') ||
                  description.contains('hoodie') ||
                  description.contains('pants'));
        }).toList();

        setState(() {
          productos = data;
          cargando = false;
        });
      } else {
        setState(() => cargando = false);
      }
    } catch (_) {
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caballeros')),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : productos.isEmpty
              ? const Center(child: Text('No hay productos para Caballeros 😢'))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: productos.length,
                  itemBuilder: (_, i) => ProductCard(
                    imageUrl: productos[i]['images'][0],
                    title: productos[i]['title'],
                    precio:
                        double.tryParse(productos[i]['price'].toString()) ?? 0.0,
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 95, 95, 95),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CarritoScreen()),
          );
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
