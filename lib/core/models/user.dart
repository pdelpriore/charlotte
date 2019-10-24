import 'structure.dart';
import 'manager.dart';

class User {
  final String id;
  final String token;
  final String surname;
  final String name;
  final String avatar;
  final String status;
  final String mail;
  final String workPlace;
  final String description;
  final bool hasTeam;
  final Structure structure;
  final Manager manager;

  User(
      this.id,
      this.token,
      this.surname,
      this.name,
      this.avatar,
      this.status,
      this.mail,
      this.workPlace,
      this.description,
      this.hasTeam,
      this.structure,
      this.manager);

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        token = json["token"],
        surname = json["nom"],
        name = json["prenom"],
        avatar = json["avatar"],
        status = json["status"],
        mail = json["mail"],
        workPlace = json["poste"],
        description = json["description"],
        hasTeam = json["has_team"],
        structure = Structure.fromJson(json["structure"]),
        manager = Manager.fromJson(json["manager"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "nom": surname,
        "prenom": name,
        "avatar": avatar,
        "status": status,
        "mail": mail,
        "poste": workPlace,
        "description": description,
        "has_team": hasTeam,
        "structure": structure,
        "manager": manager
      };

  @override
  String toString() =>
      "User{id: $id, token: $token, nom: $surname, prenom: $name, avatar: $avatar, status: $status, mail: $mail, poste: $workPlace, description: $description, has_team: $hasTeam, structure: $structure, manager: $manager }";
}
