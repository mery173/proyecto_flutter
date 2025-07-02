import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tus providers
import 'Providers/carrito_provider.dart';
import 'Providers/usuario_provider.dart';
import 'Providers/pedido_provider.dart';

// Pantallas principales
import 'Pantallas/inicio.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => PedidoProvider()),
      ],
      child: const MyTiendaApp(),
    ),
  );
}

class MyTiendaApp extends StatelessWidget {
  const MyTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Rápida',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB3B3FF),
        scaffoldBackgroundColor: const Color(0xFFF8F8FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB3B3FF),
          foregroundColor: Colors.white,
        ),
      ),
      home: const TiendaInicio(),
    );
  }
}
