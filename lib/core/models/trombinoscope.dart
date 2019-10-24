import 'package:flutter_model/core/models/people.dart';

class Trombinoscope {
  final List<People> people;
  final String hash;

  Trombinoscope(this.people, this.hash);

  Trombinoscope.fromJson(Map<String, dynamic> json)
      : people = (json["people"] as List)
            .map((people) => People.fromJson(people))
            .toList(),
        hash = json["hash"];

  Map<String, dynamic> toJson() => {"people": people, "hash": hash};
}
