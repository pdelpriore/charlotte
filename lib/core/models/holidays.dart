import 'package:flutter_model/core/models/holiday_item.dart';

class Holidays {
  final double total;
  final List<HolidayItem> holidayItems;

  Holidays(this.total, this.holidayItems);

  Holidays.fromJson(Map<String, dynamic> json)
      : total = json["total"],
        holidayItems = (json["list"] as List)
            .map((holidayItem) => HolidayItem.fromJson(holidayItem))
            .toList();

  Map<String, dynamic> toJson() => {"total": total, "list": holidayItems};
}
