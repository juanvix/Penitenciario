import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:penitenciario/widgets/widgets.dart';
import 'package:penitenciario/models/models.dart';
import 'package:penitenciario/services/services.dart';
import 'package:penitenciario/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final internosService = Provider.of<InternosService>(context);

    //if (internosService.isLoading) return LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Internos'),
        ),
        body: ListView.builder(
          itemCount: internosService.internos.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              internosService.selectedInterno =
                  internosService.internos[index].copy();
              Navigator.pushNamed(context, 'internos');
            },
            child: InternoCard(
              interno: internosService.internos[index],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            internosService.selectedInterno =
                new Interno(name: '', observaciones: '', surname: '', niss: '');
            Navigator.pushNamed(context, 'internos');
          },
          child: const Icon(Icons.person_add),
        ));
  }
}
