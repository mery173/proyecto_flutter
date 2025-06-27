import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Imports personalizados
import 'Componentes/producto.dart';
import 'Componentes/categorias.dart';
import 'Pantallas/carrito.dart';
import 'Ventanas/login.dart';
import 'Pantallas/damas.dart';
import 'Pantallas/caballeros.dart';
import 'Pantallas/ofertas.dart';
import 'Providers/carrito_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CarritoProvider())],
      child: const MyTiendaApp(),
    ),
  );
}

class MyTiendaApp extends StatelessWidget {
  const MyTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Rápida',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB3B3FF),
        scaffoldBackgroundColor: const Color(0xFFF8F8FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB3B3FF),
          foregroundColor: Colors.white,
        ),
      ),
      home: const TiendaInicio(),
    );
  }
}

class TiendaInicio extends StatefulWidget {
  const TiendaInicio({super.key});

  @override
  State<TiendaInicio> createState() => _TiendaInicioState();
}

class _TiendaInicioState extends State<TiendaInicio> {
  List productos = [];
  bool cargando = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    obtenerProductos();
  }

  Future<void> obtenerProductos() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products'),
      );
      if (response.statusCode == 200) {
        setState(() {
          productos = json.decode(response.body);
          cargando = false;
        });
      } else {
        setState(() {
          error = true;
          cargando = false;
        });
      }
    } catch (e) {
      setState(() {
        error = true;
        cargando = false;
      });
    }
  }

  void _mostrarLogin(BuildContext context) {
    showDialog(context: context, builder: (_) => const DialogLogin());
  }

  void _irAlCarrito(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CarritoScreen()),
    );
  }

  void _irACategoria(BuildContext context, Widget categoriaPage) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => categoriaPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tienda Rápida'),
        actions: [
          TextButton(
            onPressed: () => _mostrarLogin(context),
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 179, 179, 243),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Iniciar sesión'),
          ),
        ],
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : error
          ? const Center(child: Text('Error al cargar productos 😢'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 180,
                        child: Image.asset(
                          'assets/images/bannertt.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Productos :',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Productos
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        final imageUrl =
                            (producto['images'] != null &&
                                producto['images'].isNotEmpty &&
                                producto['images'][0].toString().startsWith(
                                  'http',
                                ))
                            ? producto['images'][0]
                            : 'https://via.placeholder.com/150';

                        return ProductCard(
                          imageUrl: imageUrl,
                          title: producto['title'],
                          precio:
                              double.tryParse(producto['price'].toString()) ??
                              0.0,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Categorías
                  const Text(
                    'Categorías',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        CategoryItem(
                          icon: Icons.woman,
                          label: 'Damas',
                          onTap: () =>
                              _irACategoria(context, const DamasScreen()),
                        ),
                        CategoryItem(
                          icon: Icons.man,
                          label: 'Caballeros',
                          onTap: () =>
                              _irACategoria(context, const CaballerosScreen()),
                        ),
                        CategoryItem(
                          icon: Icons.shopping_bag,
                          label: 'Ofertas',
                          onTap: () =>
                              _irACategoria(context, const OfertasScreen()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 51, 51, 145),
        onPressed: () => _irAlCarrito(context),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
