import 'package:flutter/material.dart';

class CarritoProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _carrito = [];

  // Getter para obtener la lista del carrito
  List<Map<String, dynamic>> get carrito => _carrito;

  // Agregar producto al carrito
  void agregarProducto(Map<String, dynamic> producto) {
    _carrito.add(producto);
    notifyListeners();
  }

  // Eliminar producto por índice
  void eliminarProducto(int index) {
    _carrito.removeAt(index);
    notifyListeners();
  }

  // Limpiar todo el carrito
  void limpiarCarrito() {
    _carrito.clear();
    notifyListeners();
  }

  // Calcular el total del carrito
  double totalCarrito() {
    double total = 0;
    for (var item in _carrito) {
      total += item['precio'];
    }
    return total;
  }
}
