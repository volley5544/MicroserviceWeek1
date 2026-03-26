package com.volley5544.demo.routes;

import com.volley5544.demo.Controllers.*;
import java.util.HashMap;
import java.util.Map;

public class Web {
    public static Map<String, Object[]> routes = new HashMap<>();

    static {
        routes.put("/", new Object[]{new UserController(), "index"});
        routes.put("/home", new Object[]{new HomeController(), "index"});
        routes.put("/api/users", new Object[]{new UserController(), "index"});
    }
}
