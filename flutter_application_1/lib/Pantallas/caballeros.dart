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
        Uri.parse('https://api.escuelajs.co/api/v1/categories/2/products'),
      );
      if (response.statusCode == 200) {
        setState(() {
          productos = json.decode(response.body);
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
