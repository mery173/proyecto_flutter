import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Pantallas/registro.dart'; // 👈 Dialog de registro

class DialogLogin extends StatefulWidget {
  const DialogLogin({super.key});

  @override
  State<DialogLogin> createState() => _DialogLoginState();
}

class _DialogLoginState extends State<DialogLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /// 👉 Método para iniciar sesión con Firebase
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // ✅ Autenticarse con Firebase Auth
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // ✅ Obtener datos adicionales desde Firestore
      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .get();

      final nombre = doc.data()?['nombre'] ?? 'Usuario';

      // ✅ Actualizar Provider local
      Provider.of<UsuarioProvider>(context, listen: false).login(nombre, email);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inicio de sesión correcto'),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Iniciar sesión'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
              validator: (value) => value!.isEmpty ? 'Ingrese su correo' : null,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              validator: (value) =>
                  value!.isEmpty ? 'Ingrese su contraseña' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // 👉 Abre el diálogo de registro
            showDialog(
              context: context,
              builder: (_) => const DialogRegistro(),
            );
          },
          child: const Text('Registrarse'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 133, 230, 95),
            foregroundColor: const Color.fromARGB(255, 7, 7, 7),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _login();
            }
          },
          child: const Text('Entrar'),
        ),
      ],
    );
  }
}
