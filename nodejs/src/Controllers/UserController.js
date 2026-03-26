const Logger = require('../Core/Logger');

class UserController {
  index() {
    Logger.info("User list requested");

    const users = [
      { id: 1, name: "John" },
      { id: 2, name: "Jane" },
      { id: 3, name: "Mike" },
    ];

    return {
      status: "success",
      data: users
    };
  }
}

module.exports = UserController;