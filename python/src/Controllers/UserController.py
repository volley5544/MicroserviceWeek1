from src.Core.Logger import Logger

class UserController:
    def index(self):
        Logger.info("User list requested")

        users = [
            {"id": 1, "name": "John"},
            {"id": 2, "name": "Jane"},
            {"id": 3, "name": "Mike"},
        ]

        return {
            "status": "success",
            "data": users
        }