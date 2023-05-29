import 'package:intl/intl.dart';

class DateHelpers {
  /// Friendly text for a [DateTime]
  static String formatForUser({required DateTime startDate, DateTime? now}) {
    final _now = now ?? DateTime.now();
    final lastMidnight = DateTime(_now.year, _now.month, _now.day);
    final yesterdayMidnight = DateTime(_now.year, _now.month, _now.day)
        .subtract(const Duration(days: 1));
    final sixDaysAgoMidnight = DateTime(_now.year, _now.month, _now.day)
        .subtract(const Duration(days: 6));

    if (startDate.isAfter(lastMidnight)) {
      return "Today";
    }
    if (startDate.isAfter(yesterdayMidnight)) {
      return "Yesterday";
    }
    if (startDate.isAfter(sixDaysAgoMidnight)) {
      return DateFormat('EEEE, h:mma').format(startDate);
    }
    return DateFormat('MMM d, h:mma').format(startDate);
  }
}
