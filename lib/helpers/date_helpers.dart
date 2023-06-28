import 'package:intl/intl.dart';

class DateHelpers {
  /// Friendly text for a [DateTime]
  static String formatForUser({required DateTime date, DateTime? injectedNow}) {
    final now = injectedNow ?? DateTime.now();

    if (now.isAfter(date)) {
      return _formatForDateInPast(now, date);
    } else {
      return _formatForDateInFuture(now, date);
    }
  }

  static String _formatForDateInFuture(DateTime now, DateTime date) {
    final tomorrowMidnight =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    final twoDaysFromNowMidnight =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 2));

    if (date.isBefore(tomorrowMidnight)) {
      return "Today";
    }
    if (date.isBefore(twoDaysFromNowMidnight)) {
      return "Tomorrow";
    }
    return DateFormat('MMM d, h:mma').format(date);
  }

  static String _formatForDateInPast(DateTime now, DateTime date) {
    final lastMidnight = DateTime(now.year, now.month, now.day);
    final yesterdayMidnight = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 1));
    final sixDaysAgoMidnight = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 6));

    if (date.isAfter(lastMidnight)) {
      return "Today";
    }
    if (date.isAfter(yesterdayMidnight)) {
      return "Yesterday";
    }
    if (date.isAfter(sixDaysAgoMidnight)) {
      return DateFormat('EEEE, h:mma').format(date);
    }
    return DateFormat('MMM d, h:mma').format(date);
  }
}
