import 'package:flutter/material.dart';
import '../Modelos/pedido.dart';

class PedidoProvider extends ChangeNotifier {
  final List<Pedido> _pedidos = [];

  List<Pedido> get pedidos => _pedidos;

  void agregarPedido(double total) {
    final nuevoPedido = Pedido(
      id: _pedidos.length + 1,
      total: total,
      fecha: DateTime.now(),
    );
    _pedidos.add(nuevoPedido);
    notifyListeners();
  }
}
