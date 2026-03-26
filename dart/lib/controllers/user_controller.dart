import '../core/logger.dart';

class UserController {
  Map<String, dynamic> index() {
    Logger.info("User list requested");

    final users = [
      {"id": 1, "name": "John"},
      {"id": 2, "name": "Jane"},
      {"id": 3, "name": "Mike"},
    ];

    return {
      "status": "success",
      "data": users
    };
  }
}