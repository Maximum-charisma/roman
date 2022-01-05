import 'package:ridbrain_project/services/objects.dart';

extension Times on DateTime {
  int secondsSinceEpoch() {
    return millisecondsSinceEpoch ~/ 1000;
  }
}

extension Records on List<Record> {
  List<Record> forDate(DateTime date) {
    List<Record> events = [];

    var start = date.secondsSinceEpoch();
    var end = start + 86400;

    for (var item in this) {
      if (item.recordDate >= start && item.recordDate < end) {
        events.add(item);
      }
    }

    return events;
  }
}
