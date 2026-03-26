package com.volley5544.demo;

import com.volley5544.demo.Core.Logger;
import com.volley5544.demo.routes.Web;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Method;
import java.util.Map;

@RestController
public class Router {

    @RequestMapping(value = "/**")
    public Object handle(HttpServletRequest request) {

        String uri = request.getRequestURI();
        uri = uri.replaceAll("/$", "");
        if (uri.isEmpty()) uri = "/";

        try {
            if (Web.routes.containsKey(uri)) {
                Object[] route = Web.routes.get(uri);

                Object controller = route[0];
                String methodName = (String) route[1];

                Method method = controller.getClass().getMethod(methodName);
                return method.invoke(controller);
            } else {
                Logger.error("Route not found: " + uri);

                return Map.of(
                        "status", "error",
                        "message", "Not Found"
                );
            }
        } catch (Exception e) {
            Logger.error(e.getMessage());

            return Map.of(
                    "status", "error",
                    "message", "Server Error"
            );
        }
    }
}
