import 'package:flutter/material.dart';
import 'package:penitenciario/widgets/widgets.dart';

class AnadirInternosScreen extends StatelessWidget {
  const AnadirInternosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Internos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return InternoCard();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person_add),
      ),
    );
  }
}
