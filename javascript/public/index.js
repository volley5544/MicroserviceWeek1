const express = require('express');
const routes = require('../routes/web');
const Logger = require('../src/Core/Logger');

const app = express();
app.use(express.json());

// normalize path like PHP
function normalizePath(path) {
  return path.replace(/\/+$/, '') || '/';
}

// dynamic routing (like your PHP array)
Object.keys(routes).forEach((routePath) => {
  const [Controller, method] = routes[routePath];

  app.all(routePath, async (req, res) => {
    try {
      const controller = new Controller();

      const response = await controller[method](req, res);

      // mimic PHP behavior
      if (typeof response === 'string') {
        res.send(response);
      } else {
        res.json(response);
      }

    } catch (err) {
      Logger.error(err.message);

      res.status(500).json({
        status: "error",
        message: "Server Error"
      });
    }
  });
});

// 404 handler
app.use((req, res) => {
  const uri = normalizePath(req.path);

  Logger.error(`Route not found: ${uri}`);

  res.status(404).json({
    status: "error",
    message: "Not Found"
  });
});

app.listen(5544, () => {
  console.log("Server running at http://localhost:8000");
});