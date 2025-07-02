import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Componentes/producto.dart';
import '../Pantallas/carrito.dart';

class DamasScreen extends StatefulWidget {
  const DamasScreen({super.key});
  @override
  State<DamasScreen> createState() => _DamasScreenState();
}

class _DamasScreenState extends State<DamasScreen> {
  List productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarProductosDamas();
  }

  Future<void> cargarProductosDamas() async {
    List<String> categorias = [
      'womens-dresses',
      'womens-shoes',
      'womens-watches',
      'womens-bags',
      'tops',
    ];

    List allProducts = [];

    try {
      for (var categoria in categorias) {
        final response = await http.get(
          Uri.parse('https://dummyjson.com/products/category/$categoria'),
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          allProducts.addAll(data['products']);
        }
      }

      setState(() {
        productos = allProducts;
        cargando = false;
      });
    } catch (_) {
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Damas')),
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
                imageUrl: productos[i]['thumbnail'],
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
