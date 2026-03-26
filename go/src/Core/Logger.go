package Core

import (
	"encoding/json"
	"os"
	"time"
)

var logFile = "storage/logs/app.log"

func Info(message string) {
	write("INFO", message, nil, nil)
}

func Error(message string) {
	write("ERROR", message, nil, nil)
}

func write(level string, message string, meta map[string]interface{}, data map[string]interface{}) {
	log := map[string]interface{}{
		"timestamp": time.Now().Format(time.RFC3339),
		"message":   message,
		"level":     level,
		"trace_id":  generateTraceID(),
		"service":   "users-api",
		"meta_data": meta,
		"data":      data,
	}

	f, _ := os.OpenFile(logFile, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	defer f.Close()

	json.NewEncoder(f).Encode(log)
}

func generateTraceID() string {
	return randomHex(8) + "," + randomHex(8)
}

func randomHex(n int) string {
	bytes := make([]byte, n)
	for i := range bytes {
		bytes[i] = byte(65 + i%26)
	}
	return string(bytes)
}
