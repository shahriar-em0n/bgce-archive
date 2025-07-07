package classnotes

import (
	"fmt"
	"net/http"
)

func ClassnotesHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Showing all Class Notes")
}
