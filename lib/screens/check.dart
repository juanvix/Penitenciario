import 'package:flutter/material.dart';
import 'package:penitenciario/screens/screens.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
        body: Center(
      child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return const Text('');
          }

          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => HomeScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            });
          }
          return (Container());
        },
      ),
    ));
  }
}
