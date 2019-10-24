class HolidaysFrance {
  final String date;
  final String holidayName;

  HolidaysFrance(this.date, this.holidayName);

  HolidaysFrance.fromJson(Map<String, dynamic> json)
      : date = json["date"],
        holidayName = json["nom_jour_ferie"];

  Map<String, dynamic> toJson() => {
        "date": date,
        "nom_jour_ferie": holidayName,
      };

  @override
  String toString() =>
      "HolidaysFrance{date: $date, nom_jour_ferie: $holidayName}";
}
