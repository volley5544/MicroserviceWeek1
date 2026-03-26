from src.Controllers.HomeController import HomeController
from src.Controllers.UserController import UserController

routes = {
    "/": (UserController, "index"),
    "/home": (HomeController, "index"),
    "/api/users": (UserController, "index"),
}