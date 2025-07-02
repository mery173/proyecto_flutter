import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';
import '../Ventanas/login.dart'; // 👈 Importa tu diálogo de login

class MiCuentaScreen extends StatelessWidget {
  const MiCuentaScreen({super.key});

  void _mostrarLogin(BuildContext context) {
    showDialog(context: context, builder: (_) => const DialogLogin());
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi cuenta'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 👉 Foto de perfil opcional
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/perfil.jpg'),
            ),
            const SizedBox(height: 12),

            Text(
              usuario.nombre.isNotEmpty
                  ? usuario.nombre
                  : 'Usuario no registrado',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              usuario.correo.isNotEmpty
                  ? usuario.correo
                  : 'Sin correo registrado',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Saldo disponible:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'S/ ${usuario.saldo.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Recargar S/ 50'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 148, 148, 236),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (!usuario.logueado) {
                  _mostrarLogin(context);
                } else {
                  usuario.aumentarSaldo(50);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saldo recargado en S/ 50')),
                  );
                }
              },
            ),

            const SizedBox(height: 30),

            if (usuario.logueado)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  usuario.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sesión cerrada')),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar sesión'),
              ),
          ],
        ),
      ),
    );
  }
}
