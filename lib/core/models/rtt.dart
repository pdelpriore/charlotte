class Rtt {
  final double total;

  Rtt(this.total);

  Rtt.fromJson(Map<String, dynamic> json)
      : total = json["total"] == null ? null : double.parse(json["total"].toString());

  Map<String, dynamic> toJson() => {"total": total};
}
