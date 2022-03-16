import 'package:flutter/material.dart';
import 'package:penitenciario/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.green),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green, elevation: 0)),
    );
  }
}
