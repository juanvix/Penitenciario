import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:penitenciario/widgets/widgets.dart';
import 'package:penitenciario/models/models.dart';
import '../services/services.dart';

class AnadirInternosScreen extends StatelessWidget {
  const AnadirInternosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final internosService = Provider.of<InternosService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internos'),
      ),
      body: ListView.builder(
        itemCount: internosService.internos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            internosService.selectedInterno =
                InternosService.internos[index].copy();
            Navigator.pushNamed(context, 'interno');
          },
          child: InternoCard(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
