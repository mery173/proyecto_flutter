import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';
import 'inicio.dart';

class CerrarSesionScreen extends StatelessWidget {
  const CerrarSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerrar sesión'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Cerrar sesión'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 240, 91, 91),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            usuarioProvider.logout(); // ✅ Usar logout, no cerrarSesion
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const TiendaInicio()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
