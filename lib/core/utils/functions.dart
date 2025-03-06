String formatDateTime(DateTime dateTime) {
  // Define list of day names
  final List<String> dayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String dayName = dayNames[dateTime.weekday - 1];

  String day = dateTime.day.toString().padLeft(2, '0');

  String month = monthNames[dateTime.month - 1];

  String year = dateTime.year.toString();

  return '$dayName, $day $month $year';
}
