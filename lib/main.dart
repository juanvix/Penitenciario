import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:penitenciario/screens/screens.dart';
import 'package:penitenciario/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => InternosService())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion penitenciaria',
      initialRoute: 'anadir_internos',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'anadir_internos': (context) => const AnadirInternosScreen(),
        'editar_internos': (context) => const InternosScreen(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.green),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.green, elevation: 0)),
    );
  }
}
