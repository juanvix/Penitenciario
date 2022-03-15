import 'package:flutter/material.dart';
import 'package:penitenciario/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion penitenciaria',
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen()
      },
    );
  }
}
