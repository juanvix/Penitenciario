// ignore_for_file: unnecessary_new, unnecessary_this, must_be_immutable

import 'package:flutter/material.dart';
import 'package:penitenciario/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:penitenciario/widgets/widgets.dart';
import 'package:penitenciario/models/models.dart';
import 'package:penitenciario/services/services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<Interno> history = [];
  @override
  Widget build(BuildContext context) {
    final internosService = Provider.of<InternosService>(context);

    if (internosService.isLoading) return const LoadingScreen();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Internos'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchInterno("Buscar", this.history),
                  );
                },
                icon: const Icon(Icons.search))
          ],
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

class SearchInterno extends SearchDelegate {
  String? nissa;

  final String searchFieldLabel;
  final List<Interno> history;

  SearchInterno(this.searchFieldLabel, this.history);

  Widget _showInternos(List<Interno> internos) {
    return ListView.builder(
      itemCount: internos.length,
      itemBuilder: (context, i) {
        final interno = internos[i];

        return ListTile(
          title: Text(interno.name! + '' + interno.surname!),
          onTap: () {
            this.close(context, interno);
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => this.close(context, null));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(query),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Text('No hay valor en la busqueda');
    }

    final internoService = new InternosService();
    return FutureBuilder(
      future: internoService.getInternoByNiss(query),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const ListTile(title: Text('No hay nada con ese término'));
        }

        if (snapshot.hasData) {
          // crear la lista
          return _showInternos(snapshot.data);
        } else {
          // Loading
          return const Center(child: CircularProgressIndicator(strokeWidth: 4));
        }
      },
    );
  }
}
