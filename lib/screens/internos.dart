// ignore_for_file: unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penitenciario/providers/providers.dart';
import 'package:penitenciario/widgets/widgets.dart';
import 'package:penitenciario/services/services.dart';
import 'package:penitenciario/ui/input_decorations.dart';

class InternosScreen extends StatelessWidget {
  const InternosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final internosService = Provider.of<InternosService>(context);

    return ChangeNotifierProvider(
      create: (_) => InternoFormProvider(internosService.selectedInterno),
      child: _InternosScreenBody(internosService: internosService),
    );
  }
}

class _InternosScreenBody extends StatelessWidget {
  const _InternosScreenBody({
    Key? key,
    required this.internosService,
  }) : super(key: key);

  final InternosService internosService;
  @override
  Widget build(BuildContext context) {
    final internoForm = Provider.of<InternoFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                InternoImage(url: internosService.selectedInterno.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(

                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null) {
                          print('No seleccionó nada');
                          return;
                        }

                        internosService
                            .updateSelectedInternoImage(pickedFile.path);
                      },
                      icon: const Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
              ],
            ),
            _InternoForm(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: internosService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
        onPressed: internosService.isSaving
            ? null
            : () async {
                if (!internoForm.isValidForm()) return;

                final String? imageUrl = await internosService.uploadImage();

                if (imageUrl != null) internoForm.interno.picture = imageUrl;

                await internosService.saveOrCreateInterno(internoForm.interno);
              },
      ),
    );
  }
}

class _InternoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final internoForm = Provider.of<InternoFormProvider>(context);
    final interno = internoForm.interno;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: internoForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: interno.niss,
                onChanged: (value) => interno.niss = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El niss es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Niss del interno', labelText: 'Niss:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: interno.name,
                onChanged: (value) => interno.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del interno', labelText: 'Nombre:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: interno.surname,
                onChanged: (value) => interno.surname = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Los apellidos son obligatorios';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Apellidos del interno', labelText: 'Apellidos:'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: interno.observaciones,
                onChanged: (value) => interno.observaciones = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Observaciones es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Observaciones del interno',
                    labelText: 'Observaciones:'),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
