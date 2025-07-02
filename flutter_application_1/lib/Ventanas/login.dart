import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';
import 'package:flutter_application_1/Pantallas/registro.dart'; // 👈 Importa el nuevo dialog de registro

class DialogLogin extends StatefulWidget {
  const DialogLogin({super.key});

  @override
  State<DialogLogin> createState() => _DialogLoginState();
}

class _DialogLoginState extends State<DialogLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // ⚡ Ejemplo básico: validar con un usuario fijo
    if (email == 'admin@tienda.com' && password == '1234') {
      Provider.of<UsuarioProvider>(
        context,
        listen: false,
      ).login('Admin', 200.0);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inicio de sesión correcta'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correo o contraseña incorrectos')),
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
            // 👇 Abre el dialog de registro
            showDialog(
              context: context,
              builder: (_) => const DialogRegistro(),
            );
          },
          child: const Text('Registrarse'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 130, 130, 223),
            foregroundColor: Colors.white,
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
