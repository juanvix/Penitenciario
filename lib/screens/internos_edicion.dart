import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penitenciario/screens/screens.dart';

import 'package:penitenciario/providers/providers.dart';
import 'package:penitenciario/ui/input_decorations.dart';
import 'package:penitenciario/services/services.dart';
import 'package:penitenciario/widgets/widgets.dart';

class InternosScreen extends StatelessWidget {
  const InternosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final internoService = Provider.of<InternosService>(context);

    if (internoService.isLoading) return LoadingScreen();

    return ChangeNotifierProvider(
      create: (_) => InternoFormProvider(internoService.selectedInterno),
      child: _InternoScreenBody(internoService: internoService),
    );
  }
}

class _InternoScreenBody extends StatelessWidget {
  const _InternoScreenBody({
    Key? key,
    required this.internoService,
  }) : super(key: key);

  final InternosService internoService;

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
                InternoImage(url: internoService.selectedInterno.picture),
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
                        final PickedFile? pickedFile = await picker.getImage(
                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null) {
                          print('No seleccionó nada');
                          return;
                        }

                        internoService
                            .updateSelectedInternoImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
              ],
            ),
            _InternoForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: internoService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined),
        onPressed: internoService.isSaving
            ? null
            : () async {
                if (!internoForm.isValidForm()) return;

                final String? imageUrl = await internoService.uploadImage();

                if (imageUrl != null) internoForm.interno.picture = imageUrl;

                await internoService.saveOrCreateInterno(internoForm.interno);
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: internoForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: interno.niss,
                onChanged: (value) => interno.niss = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El niss es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Niss del interno', labelText: 'Niss:'),
              ),
              TextFormField(
                initialValue: interno.name,
                onChanged: (value) => interno.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del interno', labelText: 'Nombre:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: interno.surname,
                onChanged: (value) => interno.surname = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El apellido es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Apellido del interno', labelText: 'Apellido:'),
              ),
              TextFormField(
                initialValue: interno.observaciones,
                onChanged: (value) => interno.observaciones = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Observaciones es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Observaciones del interno',
                    labelText: 'Observaciones:'),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
