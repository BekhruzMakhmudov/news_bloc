import 'package:intl/intl.dart';
String formatDateTime(String? dateTimeString) {
  if(dateTimeString==null) return "Unknown date";
  DateTime parsedDate = DateTime.parse(dateTimeString);
  return DateFormat('HH:mm, dd MMMM yyyy').format(parsedDate);
}