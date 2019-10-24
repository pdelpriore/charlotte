class Manager {
  final String id;
  final String surname;
  final String name;
  final String mail;
  final String phone;
  final String cellPhone;

  Manager(this.id, this.surname, this.name, this.mail, this.phone, this.cellPhone);

  Manager.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        surname = json["nom"],
        name = json["prenom"],
        mail = json["mail"],
        phone = json["tel"],
        cellPhone = json["portable"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": surname,
        "prenom": name,
        "mail": mail,
        "tel": phone,
        "portable": cellPhone
      };

  @override
  String toString() =>
      "Manager{id: $id, nom: $surname, prenom: $name, mail: $mail, tel: $phone, portable: $cellPhone}";
}
