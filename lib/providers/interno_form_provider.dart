import 'package:flutter/material.dart';
import 'package:penitenciario/models/models.dart';

class InternoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Interno interno;

  InternoFormProvider(this.interno);

  bool isValidForm() {
    print(interno.name);
    print(interno.surname);
    print(interno.niss);

    return formKey.currentState?.validate() ?? false;
  }
}
