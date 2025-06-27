import 'package:flutter/material.dart';

class CarritoProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _carrito = [];

  List<Map<String, dynamic>> get carrito => _carrito;

  void agregarProducto(Map<String, dynamic> producto) {
    _carrito.add(producto);
    notifyListeners();
  }

  void eliminarProducto(int index) {
    _carrito.removeAt(index);
    notifyListeners();
  }

  void limpiarCarrito() {
    _carrito.clear();
    notifyListeners();
  }
}
