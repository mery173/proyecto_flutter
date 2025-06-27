import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Componentes/producto.dart';
import '../Pantallas/carrito.dart';

class OfertasScreen extends StatefulWidget {
  const OfertasScreen({super.key});
  @override
  State<OfertasScreen> createState() => _OfertasScreenState();
}

class _OfertasScreenState extends State<OfertasScreen> {
  List productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarOfertas();
  }

  Future<void> cargarOfertas() async {
    try {
      final r = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products'),
      );
      if (r.statusCode == 200) {
        List all = json.decode(r.body);
        productos = all
            .where((p) => (p['price'] as num) < 50)
            .toList(); // Filtrar por precio
      }
    } catch (_) {}
    setState(() => cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ofertas')),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
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
                precio: double.tryParse(productos[i]['price'].toString()) ?? 0,
              ),
            ),

      //  Botón flotante del carrito
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 51, 51, 145),
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
