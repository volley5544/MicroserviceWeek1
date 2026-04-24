import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import '../routes/web.dart';
import '../core/logger.dart';

String normalizePath(String path) {
  if (path.endsWith('/') && path.length > 1) {
    return path.substring(0, path.length - 1);
  }
  return path.isEmpty ? '/' : path;
}

Future<Response> handler(Request request) async {
  final uri = normalizePath(request.url.path.isEmpty ? '/' : '/${request.url.path}');

  try {
    if (routes.containsKey(uri)) {
      final action = routes[uri]!;

      final result = action();

      if (result is String) {
        return Response.ok(result);
      }

      return Response.ok(
        jsonEncode(result),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      Logger.error("Route not found: $uri");

      return Response.notFound(jsonEncode({
        "status": "error",
        "message": "Not Found"
      }));
    }
  } catch (e) {
    Logger.error(e.toString());

    return Response.internalServerError(
      body: jsonEncode({
        "status": "error",
        "message": "Server Error"
      }),
    );
  }
}

void main() async {
  final server = await io.serve(handler, '0.0.0.0', 6044);

  print('Server running on http://${server.address.host}:${server.port}');
}

int calculate(){
  return 42;
}