import 'package:intl/intl.dart';

int getTimestamp() {
  return DateTime.now().millisecondsSinceEpoch; // Returns time in HH:mm:ss format
}

String convertTimestampToDateTime(int milliseconds) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}