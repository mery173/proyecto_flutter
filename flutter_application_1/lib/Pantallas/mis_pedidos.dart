import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';

class MisPedidosScreen extends StatelessWidget {
  const MisPedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: const Color(0xFF757575),
      ),
      body: !usuario.logueado
          ? const Center(
              child: Text('Debes iniciar sesión para ver tus pedidos'),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('pedidos')
                  .where('correo', isEqualTo: usuario.correo)
                  .orderBy('fecha', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Aún no tienes pedidos 🛒'));
                }

                final pedidos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: pedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = pedidos[index];
                    final productos = pedido['productos'] as List<dynamic>;

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(
                          'Total: S/ ${pedido['total'].toStringAsFixed(2)} - ${pedido['metodoPago']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Fecha: ${(pedido['fecha'] as Timestamp).toDate().toString().substring(0, 16)}',
                        ),
                        children: productos.map((prod) {
                          return ListTile(
                            leading:
                                prod['imagen'].toString().startsWith('http')
                                ? Image.network(
                                    prod['imagen'],
                                    width: 40,
                                    height: 40,
                                  )
                                : Image.asset(
                                    prod['imagen'],
                                    width: 40,
                                    height: 40,
                                  ),
                            title: Text(prod['titulo']),
                            subtitle: Text(
                              'S/ ${prod['precio'].toStringAsFixed(2)}',
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
