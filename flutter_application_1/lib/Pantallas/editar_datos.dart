import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../Providers/usuario_provider.dart';

class EditarDatosScreen extends StatefulWidget {
  const EditarDatosScreen({super.key});

  @override
  State<EditarDatosScreen> createState() => _EditarDatosScreenState();
}

class _EditarDatosScreenState extends State<EditarDatosScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _correoController;

  @override
  void initState() {
    super.initState();
    final usuario = Provider.of<UsuarioProvider>(context, listen: false);
    _nombreController = TextEditingController(text: usuario.nombre);
    _correoController = TextEditingController(text: usuario.correo);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  Future<void> _actualizarDatos() async {
    final nuevoNombre = _nombreController.text.trim();
    final nuevoCorreo = _correoController.text.trim();
    if (!_formKey.currentState!.validate()) return;

    final usuario = Provider.of<UsuarioProvider>(context, listen: false);

    try {
      // ✅ Actualizar en Firestore usando UID
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .update({
            'nombre': nuevoNombre,
            'correo': nuevoCorreo,
            'updatedAt': Timestamp.now(),
          });

      // ✅ Actualizar Provider local
      usuario.login(usuario.uid, nuevoNombre, nuevoCorreo, usuario.saldo);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos actualizados correctamente ✅'),
            duration: Duration(milliseconds: 1500),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar datos')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese su nombre' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese su correo' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _actualizarDatos,
                icon: const Icon(Icons.save),
                label: const Text('Guardar cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
