package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

type Response struct {
	Message string `json:"message"`
	Host    string `json:"host"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusNotFound)

	hostname, _ := os.Hostname()
	response := Response{
		Message: "Default backend - 404",
		Host:    hostname,
	}

	json.NewEncoder(w).Encode(response)
}

func main() {
	http.HandleFunc("/", handler)
	port := "8080"
	fmt.Printf("Starting server on port %s\n", port)
	http.ListenAndServe(":"+port, nil)
}
