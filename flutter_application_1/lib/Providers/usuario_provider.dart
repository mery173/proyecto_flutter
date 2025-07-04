import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  String _nombre = '';
  String _correo = '';
  String _contrasena = '';
  double _saldo = 0.0;
  bool _logueado = false;

  /// 👉 Getters
  String get nombre => _nombre;
  String get correo => _correo;
  double get saldo => _saldo;
  bool get logueado => _logueado;

  /// 👉 Método para iniciar sesión y actualizar datos locales
  void login(String nombre, String correo, [double saldo = 0.0]) {
    _nombre = nombre;
    _correo = correo.trim().toLowerCase(); // ✅ Normalizamos correo
    _saldo = saldo;
    _logueado = true;
    notifyListeners();
  }

  /// 👉 Método para registrar usuario local (no en Firestore)
  void registrarLocal(String nombre, String correo, String contrasena) {
    _nombre = nombre;
    _correo = correo.trim().toLowerCase(); // ✅ Normalizamos correo
    _contrasena = contrasena;
    _saldo = 0.0;
    _logueado = true;
    notifyListeners();
  }

  /// 👉 Método para cerrar sesión
  void logout() {
    _nombre = '';
    _correo = '';
    _contrasena = '';
    _saldo = 0.0;
    _logueado = false;
    notifyListeners();
  }

  /// 👉 Setter para actualizar saldo manualmente
  set saldo(double nuevoSaldo) {
    _saldo = nuevoSaldo;
    notifyListeners();
  }

  /// 👉 Método para aumentar saldo
  void aumentarSaldo(double monto) {
    _saldo += monto;
    notifyListeners();
  }
}
