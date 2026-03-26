<?php

namespace Volley5544\PhpProject\Controllers;

use Volley5544\PhpProject\Core\Logger;

class UserController
{
    public function index()
    {

        Logger::info("User list requested");

        $users = [
            ["id" => 1, "name" => "John"],
            ["id" => 2, "name" => "Jane"],
            ["id" => 3, "name" => "Mike"],
        ];

        return json_encode([
            "status" => "success",
            "data" => $users
        ]);
    }
}