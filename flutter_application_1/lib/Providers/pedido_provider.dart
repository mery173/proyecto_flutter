import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Modelos/pedido.dart';

class PedidoProvider extends ChangeNotifier {
  final List<Pedido> _pedidos = [];

  List<Pedido> get pedidos => List.unmodifiable(_pedidos);

  Future<void> agregarPedido(double total) async {
    final nuevoPedido = Pedido(
      id: _pedidos.length + 1,
      total: total,
      fecha: DateTime.now(),
    );
    _pedidos.add(nuevoPedido);
    notifyListeners();

    // ✅ También guardamos en Firestore con uid
    await FirebaseFirestore.instance.collection('pedidos').add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'total': total,
      'fecha': Timestamp.now(),
    });
  }

  void limpiarPedidos() {
    _pedidos.clear();
    notifyListeners();
  }
}
