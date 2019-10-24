import 'package:flutter_model/core/models/holidays.dart';
import 'package:flutter_model/core/models/rtt.dart';

class UserHolidays {
  final Holidays holidays;
  final Rtt rtts;

  UserHolidays(this.holidays, this.rtts);

  UserHolidays.fromJson(Map<String, dynamic> json)
      : holidays = Holidays.fromJson(json["conges"]),
        rtts = Rtt.fromJson(json["rtts"]);

  Map<String, dynamic> toJson() => {"conges": holidays, "rtts": rtts};
}
