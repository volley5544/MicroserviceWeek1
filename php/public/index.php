<?php

use Volley5544\PhpProject\Core\Logger;
require __DIR__ . '/../vendor/autoload.php';

$routes = require __DIR__ . '/../routes/web.php';

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uri = rtrim($uri, '/') ?: '/';

header('Content-Type: application/json');

try {
    if (isset($routes[$uri])) {
        [$class, $method] = $routes[$uri];

        $controller = new $class();
        $response = $controller->$method();

        echo $response;
    } else {
        http_response_code(404);

        Logger::error("Route not found: {$uri}");

        echo json_encode([
            "status" => "error",
            "message" => "Not Found"
        ]);
    }
} catch (\Throwable $e) {
    http_response_code(500);

    Logger::error($e->getMessage());

    echo json_encode([
        "status" => "error",
        "message" => "Server Error"
    ]);
}