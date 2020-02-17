import 'package:intl/intl.dart';

class Formatters {
  static String ddMY = 'dd MMM y';
  static String yyyyMMdd = 'yyyy-MM-dd';

  static String dateToFormat(DateTime date, DateFormat format) => format.format(date);
  static String dateDifference(DateTime dateFrom, DateTime dateTo) => _getDateDiff(dateTo.difference(dateFrom).inMinutes);

  static String _getDateDiff(int minutes) {
    double hoursLeft = minutes / 60;
    int minutesLeft = minutes % 60;

    return hoursLeft.toInt().toString() + ' hours ' + minutesLeft.toString() + ' min';
  }
}