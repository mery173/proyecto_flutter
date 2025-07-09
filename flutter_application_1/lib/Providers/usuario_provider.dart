import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier {
  String _uid = ''; // ✅ Campo para UID
  String _nombre = '';
  String _correo = '';
  String _contrasena = '';
  double _saldo = 0.0;
  bool _logueado = false;

  // 👉 Getters
  String get uid => _uid;
  String get nombre => _nombre;
  String get correo => _correo;
  double get saldo => _saldo;
  bool get logueado => _logueado;

  // 👉 Método para iniciar sesión y actualizar datos locales (desde Firebase)
  void login(String uid, String nombre, String correo, double saldo) {
    _uid = uid;
    _nombre = nombre;
    _correo = correo.trim().toLowerCase();
    _saldo = saldo;
    _logueado = true;
    notifyListeners();
  }

  // 👉 Método para registrar usuario local
  void registrarLocal(String nombre, String correo, String contrasena) {
    _nombre = nombre;
    _correo = correo.trim().toLowerCase();
    _contrasena = contrasena;
    _saldo = 0.0;
    _logueado = true;
    notifyListeners();
  }

  // 👉 Método para actualizar datos
  void actualizarDatos(String nuevoNombre, String nuevoCorreo) {
    _nombre = nuevoNombre;
    _correo = nuevoCorreo.trim().toLowerCase();
    notifyListeners();
  }

  // 👉 Método para cerrar sesión
  void logout() {
    _uid = '';
    _nombre = '';
    _correo = '';
    _contrasena = '';
    _saldo = 0.0;
    _logueado = false;
    notifyListeners();
  }

  // 👉 Setter para actualizar saldo
  set saldo(double nuevoSaldo) {
    _saldo = nuevoSaldo;
    notifyListeners();
  }

  // 👉 Método para aumentar saldo
  void aumentarSaldo(double monto) {
    _saldo += monto;
    notifyListeners();
  }
}
