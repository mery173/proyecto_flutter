import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Componentes/producto.dart';
import '../Componentes/categorias.dart';
import '../Componentes/footer.dart';
import 'carrito.dart';
import '../Ventanas/login.dart';
import 'damas.dart';
import 'caballeros.dart';
import 'ofertas.dart';
import 'mis_pedidos.dart';
import 'mi_cuenta.dart';
import 'sobre_nosotros.dart';
import 'ayuda.dart';
import '../Providers/usuario_provider.dart';
import '../Providers/pedido_provider.dart';

class TiendaInicio extends StatefulWidget {
  const TiendaInicio({super.key});

  @override
  State<TiendaInicio> createState() => _TiendaInicioState();
}

class _TiendaInicioState extends State<TiendaInicio> {
  List productos = [];
  bool cargando = true;
  bool error = false;

  final List<String> promociones = [
    'assets/images/promociones/promo1.jpg',
    'assets/images/promociones/promo2.jpg',
    'assets/images/promociones/promo3.jpg',
  ];

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
        List data = json.decode(response.body);
        data = data.where((producto) {
          return producto['images'] != null &&
              producto['images'].isNotEmpty &&
              producto['images'][0].toString().startsWith('http');
        }).toList();

        setState(() {
          productos = data;
          cargando = false;
        });
      } else {
        setState(() {
          error = true;
          cargando = false;
        });
      }
    } catch (_) {
      setState(() {
        error = true;
        cargando = false;
      });
    }
  }

  void _mostrarLogin(BuildContext context) {
    showDialog(context: context, builder: (_) => const DialogLogin());
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context);
    final pedidoProvider = Provider.of<PedidoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tienda Rápida'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          if (!usuario.logueado)
            TextButton(
              onPressed: () => _mostrarLogin(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 179, 179, 243),
                foregroundColor: Colors.white,
              ),
              child: const Text('Iniciar sesión'),
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 179, 179, 243),
              ),
              child: usuario.logueado
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hola, ${usuario.nombre} 👋',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Saldo: S/ ${usuario.saldo.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : const Text(
                      'No has iniciado sesión',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Carrito'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CarritoScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Mis pedidos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MisPedidosScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mi cuenta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MiCuentaScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre nosotros'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SobreNosotrosScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Ayuda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AyudaScreen()),
                );
              },
            ),
            if (usuario.logueado)
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cerrar sesión'),
                      content: const Text(
                        '¿Estás seguro de que quieres cerrar sesión?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            usuario.logout();
                            Navigator.of(context).pop();
                            Scaffold.of(context).closeDrawer();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : error
          ? const Center(child: Text('Error al cargar productos 😢'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (usuario.logueado)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 240, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '👤 ${usuario.nombre}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Saldo: S/ ${usuario.saldo.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 200,
                          child: Image.asset(
                            'assets/images/promociones/bannertt.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Promociones:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: promociones.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            promociones[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Categorías',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        CategoryItem(
                          icon: Icons.woman,
                          label: 'Damas',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DamasScreen(),
                            ),
                          ),
                        ),
                        CategoryItem(
                          icon: Icons.man,
                          label: 'Caballeros',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CaballerosScreen(),
                            ),
                          ),
                        ),
                        CategoryItem(
                          icon: Icons.shopping_bag,
                          label: 'Ofertas',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OfertasScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Productos:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productos.length > 12 ? 12 : productos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        return ProductCard(
                          imageUrl: producto['images'][0],
                          title: producto['title'],
                          precio:
                              double.tryParse(producto['price'].toString()) ??
                              0.0,
                          onAdd: () => pedidoProvider.agregarPedido(
                            double.tryParse(producto['price'].toString()) ??
                                0.0,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Footer(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 51, 51, 145),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CarritoScreen()),
        ),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
