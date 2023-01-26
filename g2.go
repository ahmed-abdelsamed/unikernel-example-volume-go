import (
  "fmt"
  "io/ioutil"
  "net/http"
  "os"
  "path/filepath"
)

func printDir() {
  err := filepath.Walk("/",
    func(path string, info os.FileInfo, err error) error {
      if err != nil {
        return err
      }
      fmt.Println(path, info.Size())
      return nil
    })
  if err != nil {
    fmt.Println(err)
  }
}

func main() {
  printDir()

  b, err := ioutil.ReadFile("/mnt/bob.txt")
  if err != nil {
    fmt.Println(err)
  }

  fmt.Println(string(b))

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    printDir()

    b, err := ioutil.ReadFile("/mnt/bob.txt")
    if err != nil {
      fmt.Println(err)
    }

    fmt.Println(string(b))
    fmt.Fprintf(w, "Welcome to my website!")
  })

  fs := http.FileServer(http.Dir("static/"))
  http.Handle("/static/", http.StripPrefix("/static/", fs))

  go func() {
    err = http.ListenAndServe(":80", nil)
    if err != nil {
      fmt.Println(err)
    }
  }()

  http.ListenAndServe(":8080", nil)
}
