import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internos'),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.green[400],
        ),
      ),
    );
  }
}
