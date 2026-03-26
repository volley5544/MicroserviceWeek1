package main

import (
	"encoding/json"
	"log"
	"net/http"
	"strings"

	"project/routes"
	"project/src/Core"
)

func normalizePath(path string) string {
	if path == "" {
		return "/"
	}
	path = strings.TrimRight(path, "/")
	if path == "" {
		return "/"
	}
	return path
}

func handler(w http.ResponseWriter, r *http.Request) {
	uri := normalizePath(r.URL.Path)

	w.Header().Set("Content-Type", "application/json")

	if route, ok := routes.Routes[uri]; ok {
		controller := route.Controller
		method := route.Method

		result := method(controller)

		switch v := result.(type) {
		case string:
			w.Write([]byte(v))
		default:
			json.NewEncoder(w).Encode(v)
		}
	} else {
		w.WriteHeader(http.StatusNotFound)

		Core.Error("Route not found: " + uri)

		json.NewEncoder(w).Encode(map[string]interface{}{
			"status":  "error",
			"message": "Not Found",
		})
	}
}

func main() {
	http.HandleFunc("/", handler)

	log.Println("Server running on :8080")
	http.ListenAndServe(":8080", nil)
}