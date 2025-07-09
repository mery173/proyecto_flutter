import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';
import '../Ventanas/login.dart';
import 'editar_datos.dart';

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
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/perfil.jpg'),
            ),
            const SizedBox(height: 12),
            Text(
              usuario.nombre.isNotEmpty
                  ? usuario.nombre
                  : 'Usuario no registrado',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
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
                backgroundColor: const Color(0xFF757575),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                if (!usuario.logueado) {
                  _mostrarLogin(context);
                } else {
                  usuario.aumentarSaldo(50);

                  // ✅ Guardar nuevo saldo en Firestore
                  await FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(usuario.uid)
                      .update({'saldo': usuario.saldo});

                  // ✅ Mostrar SnackBar con duración más corta
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saldo recargado en S/ 100'),
                      duration: Duration(milliseconds: 1500), // ⚡️ Solo 1.5 s
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Actualizar datos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (usuario.logueado) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditarDatosScreen(),
                    ),
                  );
                } else {
                  _mostrarLogin(context);
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
                    const SnackBar(
                      content: Text('Sesión cerrada'),
                      duration: Duration(milliseconds: 1500), // ⚡️ 1.5 s
                    ),
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
