import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:penitenciario/screens/screens.dart';
import 'package:penitenciario/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternosService()),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: const MyApp(),
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
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => HomeScreen(),
        'internos': (context) => const InternosScreen(),
        'register': (context) => const RegisterScreen(),
        'check': (context) => const CheckScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.green),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.green, elevation: 0)),
    );
  }
}
