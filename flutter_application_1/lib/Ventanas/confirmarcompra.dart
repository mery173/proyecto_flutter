import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../Providers/carrito_provider.dart';

class ConfirmarCompraDialog extends StatefulWidget {
  final String nombre;
  final String correo;
  final double total;
  final List productos;

  const ConfirmarCompraDialog({
    super.key,
    required this.nombre,
    required this.correo,
    required this.total,
    required this.productos,
  });

  @override
  State<ConfirmarCompraDialog> createState() => _ConfirmarCompraDialogState();
}

class _ConfirmarCompraDialogState extends State<ConfirmarCompraDialog> {
  String metodoPago = 'Tarjeta';

  Future<void> _confirmarCompra() async {
    try {
      await FirebaseFirestore.instance.collection('pedidos').add({
        'nombre': widget.nombre,
        'correo': widget.correo
            .trim()
            .toLowerCase(), // ✅ Normalizamos el correo
        'total': widget.total,
        'metodoPago': metodoPago,
        'productos': widget.productos
            .map(
              (e) => {
                'titulo': e['title'],
                'precio': e['precio'],
                'imagen': e['image'],
              },
            )
            .toList(),
        'fecha': Timestamp.now(),
      });

      Provider.of<CarritoProvider>(context, listen: false).limpiarCarrito();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compra realizada exitosamente ✅'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop(); // Cerrar el dialog
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al realizar compra: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Ajusta al contenido
          children: [
            const Center(
              child: Text(
                'Confirmar Compra',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text('Nombre: ${widget.nombre}'),
            Text(
              'Correo: ${widget.correo.trim().toLowerCase()}',
            ), // ✅ Mostramos normalizado también
            const SizedBox(height: 10),
            const Text(
              'Productos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...widget.productos.map(
              (p) => ListTile(
                leading: p['image'].toString().startsWith('http')
                    ? Image.network(p['image'], width: 40, height: 40)
                    : Image.asset(p['image'], width: 40, height: 40),
                title: Text(p['title']),
                subtitle: Text('\$${p['precio'].toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: \$${widget.total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Método de pago:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Tarjeta'),
              value: 'Tarjeta',
              groupValue: metodoPago,
              onChanged: (value) {
                setState(() {
                  metodoPago = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Yape'),
              value: 'Yape',
              groupValue: metodoPago,
              onChanged: (value) {
                setState(() {
                  metodoPago = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: _confirmarCompra,
                icon: const Icon(Icons.check),
                label: const Text('Confirmar compra'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
