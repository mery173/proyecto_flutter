import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  String _nombre = '';
  String _correo = '';
  String _contrasena = '';
  double _saldo = 0.0;
  bool _logueado = false;

  String get nombre => _nombre;
  String get correo => _correo;
  double get saldo => _saldo;
  bool get logueado => _logueado;

  /// 👉 Método para iniciar sesión
  void login(String nombre, double saldo) {
    _nombre = nombre;
    _saldo = saldo;
    _logueado = true;
    notifyListeners();
  }

  /// 👉 Método para registrar usuario
  void registrar(String nombre, String correo, String contrasena) {
    _nombre = nombre;
    _correo = correo;
    _contrasena = contrasena;
    _saldo = 0.0; // O puedes poner saldo inicial si quieres
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

  /// 👉 Permite actualizar saldo manualmente
  set saldo(double nuevoSaldo) {
    _saldo = nuevoSaldo;
    notifyListeners();
  }

  /// 👉 Método para aumentar saldo (sin SharedPreferences)
  void aumentarSaldo(double monto) {
    _saldo += monto;
    notifyListeners();
  }
}
