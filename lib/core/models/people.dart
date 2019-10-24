import 'package:flutter_model/core/models/structure.dart';

class People {
  final String structureIcon;
  final String email;
  final String landPhone;
  final String photo;
  final String cellPhone;
  final String surname;
  final String name;
  final int birthday;
  final String workPlace;
  final Structure structure;
  final String bu;

  People(
      this.structureIcon,
      this.email,
      this.landPhone,
      this.photo,
      this.cellPhone,
      this.surname,
      this.name,
      this.birthday,
      this.workPlace,
      this.structure,
      this.bu);

  People.fromJson(Map<String, dynamic> json)
      : structureIcon = json["structure_icon"],
        email = json["mail_bureau"],
        landPhone = json["tel_bureau"],
        photo = json["photo"] == null ? null : json["photo"],
        cellPhone = json["portable"] == null ? null : json["portable"],
        surname = json["nom"],
        name = json["prenom"],
        birthday = json["date_naissance"],
        workPlace = json["poste"],
        structure = Structure.fromJson(json["structure"]),
        bu = json["bu"];

  Map<String, dynamic> toJson() => {
        "structureIcon": structureIcon,
        "mailBureau": email,
        "telBureau": landPhone,
        "photo": photo,
        "portable": cellPhone,
        "nom": surname,
        "prenom": name,
        "dateNaissance": birthday,
        "poste": workPlace,
        "structure": structure,
        "bu": bu
      };

  @override
  String toString() =>
      "People{structureIcon: $structureIcon, mailBureau: $email, telBureau: $landPhone, photo: $photo, portable: $cellPhone, nom: $surname, prenom: $name, dateNaissance: $birthday, poste: $workPlace, structure: $structure, bu: $bu}";
}
