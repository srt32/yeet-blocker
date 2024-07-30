package main

import "net/http"

func main() {
	http.HandleFunc("/yolo", func(w http.ResponseWriter, r *http.Request) {
		// log to stdout
		println("yolo called")
		w.WriteHeader(http.StatusOK)
	})

	http.HandleFunc("/yeet", func(w http.ResponseWriter, r *http.Request) {
		println("yeet called")
		w.Header().Set("X-GitHub-Edge-Resource", "false-404")
		w.WriteHeader(http.StatusNotFound)
	})

	http.ListenAndServe(":8080", nil)
}
