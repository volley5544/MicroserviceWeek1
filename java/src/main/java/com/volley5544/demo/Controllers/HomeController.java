package com.volley5544.demo.Controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
public class HomeController {
    public String index() {
        return "Hello from HomeController";
    }
}
