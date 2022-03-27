// To parse this JSON data, do
//
//     final interno = internoFromJson(jsonString);

// ignore_for_file: unnecessary_this

import 'dart:convert';

class Interno {
  String? name;
  String? observaciones;
  String? picture;
  String? surname;
  String? niss;

  Interno(
      {this.name, this.observaciones, this.picture, this.surname, this.niss});

  //factory Interno.fromJson(String str) => Interno.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Interno.fromMap(Map<String, dynamic> json) => Interno(
      name: json["name"],
      observaciones: json["observaciones"],
      picture: json["picture"],
      surname: json["surname"],
      niss: json["niss"]);

  Map<String, dynamic> toMap() => {
        "name": name,
        "observaciones": observaciones,
        "picture": picture,
        "surname": surname,
        "niss": niss
      };

  static Interno fromJson(Map json) {
    return Interno(
      name: json['name'],
      observaciones: json['observaciones'],
      picture: json['picture'],
      surname: json['surname'],
      niss: json['niss'],
    );
  }

  Interno copy() => Interno(
      name: this.name,
      picture: this.picture,
      surname: this.surname,
      niss: this.niss,
      observaciones: this.observaciones);
}
