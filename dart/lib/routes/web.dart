import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';

final routes = {
  '/': () => UserController().index(),
  '/home': () => HomeController().index(),
  '/api/users': () => UserController().index(),
};