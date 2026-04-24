package com.volley5544.demo.Controllers;

import com.volley5544.demo.Core.Logger;
import java.util.*;

public class UserController {

    public Map<String, Object> index() {

        Logger.info("User list requested");

        List<Map<String, Object>> users = List.of(
                Map.of("id", 1, "name", "John"),
                Map.of("id", 2, "name", "Jane"),
                Map.of("id", 3, "name", "Mike5544")
        );

        return Map.of(
                "status", "success",
                "data", users
        );
    }
}
