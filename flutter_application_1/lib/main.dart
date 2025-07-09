import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Firebase/firebase_options.dart';

// providers
import 'Providers/carrito_provider.dart';
import 'Providers/usuario_provider.dart';
import 'Providers/pedido_provider.dart';

// principal
import 'Pantallas/inicio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      title: 'LooksGreat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xFFFAFAFA,
        ), // ✅ Blanco suave global
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF757575),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF757575),
          secondary: const Color(0xFF757575),
        ),
      ),
      home: const TiendaInicio(),
    );
  }
}
