package main

import (
	"fmt"
	"net/http"
	"server/categories"
	"server/categories/classnotes"
)

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Welcome to BGCE Archive!")
}

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/", HomeHandler)

	mux.HandleFunc("/categories", categories.CategoryHandler)

	mux.HandleFunc("/categories/classnotes", classnotes.ClassnotesHandler)

	port := ":8080"
	fmt.Println("Server is running on http://localhost" + port)

	if err := http.ListenAndServe(port, mux); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
