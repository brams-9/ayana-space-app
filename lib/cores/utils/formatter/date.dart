class DateFormatter {
  static String formatDate(DateTime dt) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    final m = months[dt.month - 1];
    final d = dt.day.toString().padLeft(2, '0');
    return '$m $d, ${dt.year}';
  }

  static String formatTime(DateTime dt) {
    int h = dt.hour;
    final am = h < 12;
    h = h % 12;
    if (h == 0) h = 12;
    final mm = dt.minute.toString().padLeft(2, '0');
    final period = am ? 'AM' : 'PM';
    return '$h:$mm $period';
  }
}
