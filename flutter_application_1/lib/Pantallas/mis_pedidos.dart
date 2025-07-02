import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/pedido_provider.dart';
import '../Modelos/pedido.dart';

class MisPedidosScreen extends StatelessWidget {
  const MisPedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidosProvider = Provider.of<PedidoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
      ),
      body: pedidosProvider.pedidos.isEmpty
          ? const Center(child: Text('Aún no tienes pedidos 🛒'))
          : ListView.builder(
              itemCount: pedidosProvider.pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidosProvider.pedidos[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Pedido #${pedido.id}'),
                    subtitle: Text(
                      'Total: S/ ${pedido.total.toStringAsFixed(2)}\n'
                      'Fecha: ${pedido.fecha.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
