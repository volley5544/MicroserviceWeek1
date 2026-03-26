package com.volley5544.demo.Core;

import tools.jackson.databind.ObjectMapper;

import java.io.FileWriter;
import java.nio.file.*;
import java.time.OffsetDateTime;
import java.util.*;

public class Logger {

    private static final String LOG_FILE = "storage/logs/app.log";
    private static final ObjectMapper mapper = new ObjectMapper();

    public static void info(String message) {
        write("INFO", message, new HashMap<>(), new HashMap<>());
    }

    public static void error(String message) {
        write("ERROR", message, new HashMap<>(), new HashMap<>());
    }

    private static void write(String level, String message,
                              Map<String, Object> meta,
                              Map<String, Object> data) {
        try {
            Map<String, Object> log = new HashMap<>();
            log.put("timestamp", OffsetDateTime.now().toString());
            log.put("message", message);
            log.put("level", level);
            log.put("trace_id", UUID.randomUUID() + "," + UUID.randomUUID());
            log.put("service", "users-api");
            log.put("meta_data", meta);
            log.put("data", data);

            Files.createDirectories(Paths.get("storage/logs"));

            FileWriter writer = new FileWriter(LOG_FILE, true);
            writer.write(mapper.writeValueAsString(log) + "\n");
            writer.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
