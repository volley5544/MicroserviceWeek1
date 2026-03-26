import 'dart:convert';
import 'dart:io';

class Logger {
  static final String logFile = 'storage/logs/app.log';

  static void info(String message,
      {Map<String, dynamic>? metaData, Map<String, dynamic>? data}) {
    _write("INFO", message, metaData, data);
  }

  static void error(String message,
      {Map<String, dynamic>? metaData, Map<String, dynamic>? data}) {
    _write("ERROR", message, metaData, data);
  }

  static void _write(String level, String message,
      Map<String, dynamic>? metaData, Map<String, dynamic>? data) {
    final log = {
      "timestamp": DateTime.now().toIso8601String(),
      "message": message,
      "level": level,
      "trace_id": _generateTraceId(),
      "service": "users-api",
      "meta_data": metaData ?? {},
      "data": data ?? {},
    };

    final file = File(logFile);
    file.createSync(recursive: true);
    file.writeAsStringSync(jsonEncode(log) + "\n",
        mode: FileMode.append);
  }

  static String _generateTraceId() {
    return "${_randomHex()},${_randomHex()}";
  }

  static String _randomHex() {
    return DateTime.now().microsecondsSinceEpoch.toRadixString(16);
  }
}