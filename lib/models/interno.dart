// To parse this JSON data, do
//
//     final interno = internoFromJson(jsonString);

import 'dart:convert';

/*
Map<String, Interno> internoFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Interno>(k, Interno.fromJson(v)));

String internoToJson(Map<String, Interno> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));
*/
class Interno {
  Interno(
      {required this.name,
      required this.observaciones,
      this.picture,
      required this.surname,
      required this.niss});

  String name;
  String observaciones;
  String? picture;
  String surname;
  String? niss;

  factory Interno.fromJson(String str) => Interno.fromMap(json.decode(str));

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
  Interno copy() => Interno(
      name: this.name,
      picture: this.picture,
      surname: this.surname,
      niss: this.niss,
      observaciones: this.observaciones);
}
