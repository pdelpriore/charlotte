class HolidayItem {
  final String date;
  final String comments;
  final String duration;
  final String status;

  HolidayItem(this.date, this.comments, this.duration, this.status);

  HolidayItem.fromJson(Map<String, dynamic> json)
      : date = json["date"],
        comments = json["comments"],
        duration = json["valeur"],
        status = json["status"];

  Map<String, dynamic> toJson() => {
        "date": date,
        "comments": comments,
        "valeur": duration,
        "status": status
      };
}
