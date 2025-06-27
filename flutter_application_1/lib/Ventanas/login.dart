import 'package:flutter/material.dart';

// Widget para mostrar un formulario de login en forma de ventana emergente
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

    if (email == 'admin@tienda.com' && password == '1234') {
      Navigator.of(context).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' Inicio de sesión correcta'),
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
