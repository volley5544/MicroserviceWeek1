const HomeController = require('../src/Controllers/HomeController');
const UserController = require('../src/Controllers/UserController');

module.exports = {
  '/': [UserController, 'index'],
  '/home': [HomeController, 'index'],
  '/api/users': [UserController, 'index'],
};