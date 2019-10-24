class Structure {
  final String id;
  final String name;
  final String rtts;
  final String icon;

  Structure(this.id, this.name, this.rtts, this.icon);

  Structure.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["nom"],
        rtts = json["rtts"],
        icon = json["icon"];

  Map<String, dynamic> toJson() =>
      {"id": id, "nom": name, "rtts": rtts, "icon": icon};

  @override
  String toString() =>
      "Structure{id: $id, nom: $name, rtts: $rtts, icon: $icon}";
}
