import 'package:flutter_firebase_app/helpers/date_helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date Tests', () {
    late DateTime fakeNow;

    setUp(() {
      // April 19, 2022 @ 8:32am
      fakeNow = DateTime(2023, 6, 28, 8, 32);
    });
    group('function formatForUser', () {
      group('function _formatForDateInPast', () {
        test('should return "Today" if date occured since midnight today', () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(hours: 8, minutes: 31)),
                  now: fakeNow),
              'Today');
        });
        test(
            'should return "Yesterday" if date occured since midnight yesterday',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(hours: 9)), now: fakeNow),
              'Yesterday');
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(hours: 8, minutes: 32)),
                  now: fakeNow),
              'Yesterday');
        });
        test(
            'should return day of week abbreviated, followed by 12 hour time if date occured within the last week',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(days: 6)), now: fakeNow),
              'Thursday, 8:32AM');
        });

        test(
            'should return month abbreviated, day, 12 hour time if date occured more than a week ago',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(days: 7)), now: fakeNow),
              'Jun 21, 8:32AM');
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.subtract(Duration(days: 30)), now: fakeNow),
              'May 29, 8:32AM');
        });
      });
      group('function _formatForDateInFuture', () {
        test('should return "Today" if date occured before midnight tomorrow',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.add(Duration(hours: 3)), now: fakeNow),
              'Today');
        });

        test(
            'should return "Tomorrow" if date occured before midnight two days from now',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.add(Duration(days: 1)), now: fakeNow),
              'Tomorrow');
        });

        test(
            'Should return month abbreviated, day, 12 hour time if date occured after midnight two days from now',
            () {
          expect(
              DateHelpers.formatForUser(
                  date: fakeNow.add(Duration(days: 2)), now: fakeNow),
              'Jun 30, 8:32AM');
        });
      });
    });
  });
}
